import 'package:flutter/material.dart';
import 'package:gestbanda/models/Code.dart';
import 'package:gestbanda/widgets/main_header.dart';

import '../../../widgets/widgets.dart';

class CodeList extends StatefulWidget {
  CodeList({super.key});
  List<Code> codes = [
    Code("34532", DateTime.now().subtract(const Duration(days: 35)),
        DateTime.now().add(const Duration(days: 20))),
    Code("42583", DateTime.now().subtract(const Duration(days: 15)),
        DateTime.now().add(const Duration(days: 4))),
    Code("92745", DateTime.now().subtract(const Duration(days: 6)),
        DateTime.now().add(const Duration(days: 999999999999999999))),
    Code("09284", DateTime.now().subtract(const Duration(days: 20)),
        DateTime.now().subtract(const Duration(days: 10))),
    Code("92874", DateTime.now().subtract(const Duration(days: 35)),
        DateTime.now().add(const Duration(days: 20))),
    Code("82642", DateTime.now().subtract(const Duration(days: 70)),
        DateTime.now().add(const Duration(days: 90))),
  ];
  @override
  State<CodeList> createState() => _CodeListState();
}

class _CodeListState extends State<CodeList> {
  @override
  Widget build(BuildContext context) {
    widget.codes.sort((a, b) => b.dateEnd.compareTo(a.dateEnd));
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MainHeader(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Listado de códigos:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: widget.codes.isNotEmpty
                    ? ListView.builder(
                        itemCount: widget.codes.length,
                        itemBuilder: (context, index) {
                          final code = widget.codes[index];
                          return CustomListTile(
                            text: code.code,
                            dateCreated: code.dateCreated,
                            dateEnd: code.dateEnd,
                            editButtons: true,
                            textColor: code.dateEnd.isAfter(DateTime.now())
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.error,
                            onDelete: () {
                              setState(() {
                                widget.codes.removeAt(index);
                              });
                            },
                          );
                        },
                      )
                    : Text(
                        "La banda no tiene ningun código, por favor genera uno nuevo",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
