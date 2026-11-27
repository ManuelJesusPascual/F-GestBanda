import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/newmodels/voiceModels/voice_dto.dart';
import '../../../../widgets/custom_button.dart';
import '../../../providers/errorProvider/error_provider.dart';
import '../../../providers/voicesProvider/voices_provider.dart';

class BandVoiceAddPage extends ConsumerStatefulWidget {
  const BandVoiceAddPage({super.key});

  @override
  ConsumerState<BandVoiceAddPage> createState() => _BandVoiceAddPageState();
}

class _BandVoiceAddPageState extends ConsumerState<BandVoiceAddPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ref.read(voicesProviderProvider.notifier).getVoicesBandNotHaveList());
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = ref.watch(errorProviderProvider);
    String newVoiceName = "";

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
