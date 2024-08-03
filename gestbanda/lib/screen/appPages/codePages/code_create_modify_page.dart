import 'package:flutter/material.dart';
import 'package:gestbanda/models/Code.dart';
import 'package:gestbanda/utils/string_utilites.dart';

import '../../../widgets/widgets.dart';

class CodeCreateModify extends StatefulWidget {
  final Code code;

  CodeCreateModify({super.key, Code? code})
      : code = (code ??
                Code(
                    code: "",
                    dateCreated: DateTime.now(),
                    dateEnd: DateTime.now()))
            .copyWith();

  @override
  State<CodeCreateModify> createState() => _CodeCreateModifyState();
}

class _CodeCreateModifyState extends State<CodeCreateModify> {
  DateTime? selectedDateTime;

  Future<void> _selectDateTime(BuildContext context) async {
    final newDate = await showDateModal(context,
        initialDate: widget.code.dateEnd, isRangeSelection: false);

    if (newDate != null) {
      setState(() {
        selectedDateTime = newDate;
      });
    }
  }

  Future<void> _selectTime() async {
    final picked = await showTimeModal(
        context, TimeOfDay.fromDateTime(widget.code.dateEnd), "Hora");
    if (picked != null) {
      print(picked.minute);
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime?.year ?? widget.code.dateEnd.year,
          selectedDateTime?.month ?? widget.code.dateEnd.month,
          selectedDateTime?.day ?? widget.code.dateEnd.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.code.code.isNotEmpty ? "Modificar Código" : "Crear Código",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (widget.code.code.isNotEmpty)
              CustomTextInput(
                label: "Código",
                hint: "12345",
                initalValue: widget.code.code,
                topPadding: 20,
                leftPadding: 20,
                bottomPadding: 20,
                rightPadding: 20,
                enabled: false,
              ),
            if (widget.code.code.isNotEmpty || selectedDateTime != null)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Introducir fecha:",
                  textAlign: TextAlign.left,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16), // Bordes redondeados
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10), // Espaciado interno
                ),
                onPressed: () async {
                  await _selectDateTime(context);
                  await _selectTime();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          selectedDateTime != null
                              ? formatDateTime(selectedDateTime!, "dd/MM/yy")
                              : "Introducir fecha",
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          selectedDateTime != null
                              ? formatDateTime(selectedDateTime!, "HH:mm")
                              : "de caducidad",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Icon(Icons.calendar_month_outlined)
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
