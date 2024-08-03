import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/models/Code.dart';
import 'package:gestbanda/widgets/main_header.dart';

import '../../../config/config.dart';
import '../../../widgets/widgets.dart';

class CodeList extends StatefulWidget {
  CodeList({super.key});
  List<Code> codes = [
    Code(
        code: "34532",
        dateCreated: DateTime.now().subtract(const Duration(days: 35)),
        dateEnd: DateTime.now().add(const Duration(days: 20))),
    Code(
        code: "42583",
        dateCreated: DateTime.now().subtract(const Duration(days: 15)),
        dateEnd: DateTime.now().add(const Duration(days: 4))),
    Code(
        code: "92745",
        dateCreated: DateTime.now().subtract(const Duration(days: 6)),
        dateEnd: DateTime.now().add(const Duration(days: 999999999999999999))),
    Code(
        code: "09284",
        dateCreated: DateTime.now().subtract(const Duration(days: 20)),
        dateEnd: DateTime.now().subtract(const Duration(days: 10))),
    Code(
        code: "92874",
        dateCreated: DateTime.now().subtract(const Duration(days: 35)),
        dateEnd: DateTime.now().add(const Duration(days: 20))),
    Code(
        code: "82642",
        dateCreated: DateTime.now().subtract(const Duration(days: 70)),
        dateEnd: DateTime.now().add(const Duration(days: 90))),
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
        onPressed: () {
          context.read<RouterSimpleCubit>().pushRoute("/code_create_modify");
        },
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
                            onEdit: () {
                              context.read<RouterSimpleCubit>().pushRoute(
                                  "/code_create_modify",
                                  extra: code);
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
