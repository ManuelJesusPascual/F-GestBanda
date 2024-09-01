import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/domain/models/code.dart';

import '../../../../config/config.dart';
import '../../../../widgets/widgets.dart';

class CodeList extends ConsumerStatefulWidget {
  CodeList({super.key});
  final List<Code> codes = [
    Code(
        code: "34532",
        dateCreated: DateTime.now().subtract(const Duration(days: 35)),
        dateEnd: DateTime.now().add(const Duration(days: 20)),
        voz: "Sin voz"),
    Code(
        code: "42583",
        dateCreated: DateTime.now().subtract(const Duration(days: 15)),
        dateEnd: DateTime.now().add(const Duration(days: 4)),
        voz: "Sin voz"),
    Code(
        code: "92745",
        dateCreated: DateTime.now().subtract(const Duration(days: 6)),
        dateEnd: DateTime.now().add(const Duration(days: 999999999999999999)),
        voz: "Sin voz"),
    Code(
        code: "09284",
        dateCreated: DateTime.now().subtract(const Duration(days: 20)),
        dateEnd: DateTime.now().subtract(const Duration(days: 10)),
        voz: "Trompeta 1º Fuerte"),
    Code(
        code: "92874",
        dateCreated: DateTime.now().subtract(const Duration(days: 35)),
        dateEnd: DateTime.now().add(const Duration(days: 20)),
        voz: "Corneta 1º Fuerte"),
    Code(
        code: "82642",
        dateCreated: DateTime.now().subtract(const Duration(days: 70)),
        dateEnd: DateTime.now().add(const Duration(days: 90)),
        voz: "Sin voz"),
  ];
  @override
  ConsumerState<CodeList> createState() => _CodeListState();
}

class _CodeListState extends ConsumerState<CodeList> {
  @override
  Widget build(BuildContext context) {
    widget.codes.sort((a, b) => b.dateEnd.compareTo(a.dateEnd));
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          ref.read(appRouterProvider).push("/code_create_modify");
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Listado de códigos",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  "Listado de códigos para unirse a la banda",
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
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
                                ? const Color(0xFF388E3C)
                                : Theme.of(context).colorScheme.error,
                            onEdit: () {
                              ref
                                  .read(appRouterProvider)
                                  .push("/code_create_modify", extra: code);
                            },
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
