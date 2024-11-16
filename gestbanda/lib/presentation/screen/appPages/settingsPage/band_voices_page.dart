import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/presentation/providers/voicesProvider/voices_provider.dart';
import 'package:gestbanda/widgets/voice_tile.dart';

import '../../../../config/config.dart';
import '../../../providers/errorProvider/error_provider.dart';

class BandVoicesPage extends ConsumerWidget {
  BandVoicesPage({super.key});

  bool isFirstLoad = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voicesProvider = ref.watch(voicesProviderProvider.notifier);
    final errorMessage = ref.watch(errorProviderProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isFirstLoad) {
        voicesProvider.getVoiceList();
        isFirstLoad = false;
      }
    });

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

          router.push("/add_band_voices");
        },
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.surface),
      ),
      body: Stack(children: [
        SafeArea(
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
                if (ref.watch(voicesProviderProvider).bandVoices.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "No hay voces asignadas a esta banda",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                Expanded(
                  child: ref.watch(voicesProviderProvider).bandVoices.isEmpty
                      ? Container()
                      : ListView.builder(
                          itemCount: ref
                              .watch(voicesProviderProvider)
                              .bandVoices
                              .length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: VoiceTile(
                                voice: ref
                                    .watch(voicesProviderProvider)
                                    .bandVoices[index]
                                    .name,
                                onPressed: () {
                                  voicesProvider.removeVoiceFromBand(ref
                                      .watch(voicesProviderProvider)
                                      .bandVoices[index]
                                      .id);
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
        if (ref.watch(voicesProviderProvider).isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }
}
