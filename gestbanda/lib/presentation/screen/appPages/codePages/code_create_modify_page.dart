import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/domain/models/code.dart';
import 'package:gestbanda/utils/string_utilites.dart';

import '../../../../config/config.dart';
import '../../../../widgets/widgets.dart';

class CodeCreateModify extends ConsumerStatefulWidget {
  final Code code;

  CodeCreateModify({super.key, Code? code})
      : code = (code ??
                Code(
                    code: "",
                    voz: "Sin voz",
                    dateCreated: DateTime.now(),
                    dateEnd: DateTime.now()))
            .copyWith();

  @override
  ConsumerState<CodeCreateModify> createState() => _CodeCreateModifyState();
}

class _CodeCreateModifyState extends ConsumerState<CodeCreateModify> {
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
    String selectedVoz = widget.code.voz;

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonHideUnderline(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedVoz,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    iconSize: 24,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    dropdownColor: Theme.of(context).colorScheme.secondary,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedVoz = newValue!;
                      });
                    },
                    items: <String>[
                      'Sin voz',
                      'Corneta 1º Fuerte',
                      'Trompeta 1º Fuerte',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.surface),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                    const Icon(Icons.calendar_month_outlined)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: CustomButton(
                width: 250,
                height: 60,
                text: "Guardar",
                color: "primary",
                br: const BorderRadius.all(Radius.circular(16)),
                onPressed: () async {
                  final router = await ref.read(appRouterProvider.future);
                  router.pop();
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
