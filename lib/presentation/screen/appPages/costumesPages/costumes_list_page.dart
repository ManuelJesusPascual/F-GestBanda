import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../widgets/widgets.dart';

import '../../../../config/config.dart';
import '../../../../domain/models/costume.dart';

class NewCustomePage extends ConsumerWidget {
  NewCustomePage({super.key});

  final List<Costume> costumes = [
    Costume(
      img: "",
      name: "Fajin",
      quantity: 2,
      borrowedQuantity: 1,
    ),
    Costume(
      img: "",
      name: "Cinturon",
      quantity: 2,
      borrowedQuantity: 1,
    ),
    Costume(
      img: "",
      name: "Chaqueta",
      quantity: 2,
      borrowedQuantity: 1,
    ),
    Costume(
      img: "",
      name: "Pantalon",
      quantity: 2,
      borrowedQuantity: 1,
    ),
    Costume(
      img: "",
      name: "Hombreras",
      quantity: 2,
      borrowedQuantity: 1,
    ),
    Costume(
      img: "",
      name: "Zapatos",
      quantity: 2,
      borrowedQuantity: 1,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () async {
          final router = await ref.read(appRouterProvider.future);

          router.push("/costume_create_modify");
        },
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.surface),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const PreviewBanner(),
              Text(
                "Listado de ropas",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  "Listado de ropas que posee la banda",
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: costumes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CostumeTile(
                        costume: costumes[index],
                        onPressed: () async {
                          final router =
                              await ref.read(appRouterProvider.future);

                          router.push("/costume_create_modify",
                              extra: costumes[index]);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
