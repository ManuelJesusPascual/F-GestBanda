import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/presentation/providers/codesProvider/codes_provider.dart';
import 'package:gestbanda/presentation/providers/errorProvider/error_provider.dart';

import '../../../../config/config.dart';
import '../../../../domain/newmodels/codesModels/codes.dart';
import '../../../../widgets/widgets.dart';

class CodeList extends ConsumerStatefulWidget {
  const CodeList({super.key});

  @override
  ConsumerState<CodeList> createState() => _CodeListState();
}

class _CodeListState extends ConsumerState<CodeList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(codesProviderProvider.notifier).getBandCodes());
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = ref.watch(errorProviderProvider);

    // Obtener la lista de códigos y el mensaje de error
    final List<CodesDTO> codes = ref.watch(codesProviderProvider).codes;

    codes.sort((a, b) => b.endDate.compareTo(a.endDate));

    if (errorMessage.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              locale: const Locale('es', 'ES'),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        );
        ref.read(errorProviderProvider.notifier).setError("");
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () async {
          final router = await ref.read(appRouterProvider.future);
          router.push("/code_create_modify");
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
                child: codes.isNotEmpty
                    ? ListView.builder(
                        itemCount: codes.length,
                        itemBuilder: (context, index) {
                          final code = codes[index];
                          return CustomListTile(
                            text: code.code,
                            dateCreated: code.createdDate,
                            dateEnd: code.endDate,
                            editButtons: true,
                            textColor: code.endDate.isAfter(DateTime.now())
                                ? const Color(0xFF388E3C)
                                : Theme.of(context).colorScheme.error,
                            onEdit: () async {
                              final router =
                                  await ref.read(appRouterProvider.future);
                              router.push("/code_create_modify", extra: code);
                            },
                            onDelete: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                        "¿Estas seguro?",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        code.code,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  content: const Text(
                                    "¿Estás seguro de que deseas eliminar este código?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Cerrar el diálogo
                                      },
                                      child: const Text(
                                        "Cancelar",
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        ref
                                            .watch(
                                                codesProviderProvider.notifier)
                                            .removeCode(code.id);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Eliminar",
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              "La banda no tiene ningún código, por favor genera uno nuevo.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.grey,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
