import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/config.dart';
import '../../../../domain/newmodels/voiceModels/voice_dto.dart';
import '../../../../widgets/custom_button.dart';
import '../../../providers/errorProvider/error_provider.dart';
import '../../../providers/voicesProvider/voices_provider.dart';

class BandVoiceAddPage extends ConsumerWidget {
  BandVoiceAddPage({super.key});
  bool isFirstLoad = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voicesProvider = ref.watch(voicesProviderProvider.notifier);
    final errorMessage = ref.watch(errorProviderProvider);
    String newVoiceName = "";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isFirstLoad) {
        voicesProvider.getVoicesBandNotHaveList();
        isFirstLoad = false;
      }
    });

    final voicesNotAdded = ref.watch(voicesProviderProvider).voicesBandNotHave;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Añadir Voz",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  "Añadir voces a la banda",
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
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
                      value: null,
                      hint: Text(
                        "Selecciona una voz",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface),
                      ),
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
                        newVoiceName = newValue ?? "";
                      },
                      items: voicesNotAdded
                          .map<DropdownMenuItem<String>>((VoiceDTO value) {
                        return DropdownMenuItem<String>(
                          value: value.name,
                          child: Text(
                            value.name,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.surface),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              CustomButton(
                color: "primary",
                onPressed: () async {
                  if (newVoiceName.isNotEmpty) {
                    ref
                        .watch(voicesProviderProvider.notifier)
                        .addVoiceToBand(newVoiceName);
                  }
                },
                br: BorderRadius.circular(16),
                text: "Guardar",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
