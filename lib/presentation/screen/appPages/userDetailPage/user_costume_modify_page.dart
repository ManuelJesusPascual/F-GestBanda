import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/config.dart';
import '../../../../domain/models/costume.dart';

class UserCostumeModifyPage extends ConsumerStatefulWidget {
  final Costume costume;
  const UserCostumeModifyPage({super.key, required this.costume});

  @override
  ConsumerState<UserCostumeModifyPage> createState() =>
      _UserCostumeModifyPageState();
}

class _UserCostumeModifyPageState extends ConsumerState<UserCostumeModifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Modificar parte del traje asignado",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                "Modificar ${widget.costume.name}",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                ),
                child: TextFormField(
                  initialValue: widget.costume.borrowedQuantity.toString(),
                  keyboardType: TextInputType.text,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () async {
                              final router =
                                  await ref.read(appRouterProvider.future);

                              router.pop();
                            },
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                iconColor: const Color(0xFF388E3C)),
                            child: const Icon(
                              Icons.save_as_rounded,
                            )),
                        TextButton(
                            onPressed: () async {
                              final router =
                                  await ref.read(appRouterProvider.future);

                              router.pop();
                            },
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                iconColor: Theme.of(context).colorScheme.error),
                            child: const Icon(
                              Icons.delete_forever,
                            )),
                      ],
                    ),
                    labelText: "Cantidad Prestada",
                    hintText: "Cantidad Prestada",
                  ),
                  onChanged: (val) {
                    setState(() {
                      val.isEmpty
                          ? widget.costume.borrowedQuantity = 0
                          : widget.costume.borrowedQuantity = int.parse(val);
                    });
                  },
                )),
          ],
        ),
      )),
    );
  }
}
