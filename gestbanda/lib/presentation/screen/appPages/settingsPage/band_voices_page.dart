import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/widgets/voice_tile.dart';

import '../../../../config/config.dart';

class BandVoicesPage extends ConsumerWidget {
  BandVoicesPage({super.key});

  final List<String> voices = [
    "Corneta 1º Fuerte",
    "Corneta 1º Quinto",
    "Corneta 1º Piano",
    "Trompeta 1º Fuerte",
    "Trompeta 1º Piano",
    "Trompeta 2º Fuerte",
    "Trompeta 2º Piano",
    "Trompeta 3º Fuerte",
    "Trompeta 3º Piano"
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          ref.read(appRouterProvider).push("/add_band_voices");
        },
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.surface),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Listado de voces",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  "Listado de voces disponible para la banda",
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: voices.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: VoiceTile(
                        voice: voices[index],
                        onPressed: () {},
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
