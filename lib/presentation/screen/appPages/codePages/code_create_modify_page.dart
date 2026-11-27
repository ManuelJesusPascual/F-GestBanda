import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/domain/newmodels/codesModels/codes.dart';
import 'package:gestbanda/domain/newmodels/voiceModels/voice_dto.dart';
import 'package:gestbanda/presentation/providers/codesProvider/codes_provider.dart';
import 'package:gestbanda/presentation/providers/voicesProvider/voices_provider.dart';
import 'package:gestbanda/utils/string_utilites.dart';

import '../../../../widgets/widgets.dart';

class CodeCreateModify extends ConsumerStatefulWidget {
  final CodesDTO? code;

  const CodeCreateModify({super.key, this.code});

  @override
  ConsumerState<CodeCreateModify> createState() => _CodeCreateModifyState();
}

class _CodeCreateModifyState extends ConsumerState<CodeCreateModify> {
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    // Inicializa el provider si se pasa un code desde la navegación
    if (widget.code != null) {
      ref.read(codesProviderProvider).createModifyCode = widget.code!;
      selectedDateTime = widget.code!.endDate;
    } else {
      ref.read(codesProviderProvider).createModifyCode = CodesDTO(
          id: "",
          code: "",
          voice: VoiceDTO(id: "", name: ""),
          endDate: DateTime.now(),
          createdDate: DateTime.now());
      selectedDateTime = DateTime.now();
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final newDate = await showDateModal(context,
        initialDate: ref.read(codesProviderProvider).createModifyCode.endDate,
        isRangeSelection: false);

    if (newDate != null) {
      setState(() {
        selectedDateTime = newDate;
        ref.read(codesProviderProvider).createModifyCode =
            ref.read(codesProviderProvider).createModifyCode.copyWith(
                  endDate: DateTime(
                    newDate.year,
                    newDate.month,
                    newDate.day,
                    selectedDateTime?.hour ?? 0,
                    selectedDateTime?.minute ?? 0,
                  ),
                );
      });
    }
  }

  Future<void> _selectTime() async {
    final picked = await showTimeModal(
        context,
        TimeOfDay.fromDateTime(
            ref.read(codesProviderProvider).createModifyCode.endDate),
        "Hora");

    if (picked != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime?.year ?? DateTime.now().year,
          selectedDateTime?.month ?? DateTime.now().month,
          selectedDateTime?.day ?? DateTime.now().day,
          picked.hour,
          picked.minute,
        );
        ref.read(codesProviderProvider).createModifyCode =
            ref.read(codesProviderProvider).createModifyCode.copyWith(
                  endDate: selectedDateTime!,
                );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final code = ref
        .watch(codesProviderProvider)
        .createModifyCode; // Lee el estado actual del código

    List<VoiceDTO> voices = ref.watch(voicesProviderProvider).bandVoices;

    VoiceDTO selectedVoz;

    selectedVoz = voices.firstWhere(
      (voice) => voice.id == code.voice.id,
      orElse: () => voices.firstWhere(
        (voice) => voice.name == "Sin Voz",
      ),
    );

    ref.read(codesProviderProvider).createModifyCode =
        code.copyWith(voice: selectedVoz);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                code.code.isNotEmpty ? "Modificar Código" : "Crear Código",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (code.code.isNotEmpty)
                CustomTextInput(
                  label: "Código",
                  hint: "12345",
                  initalValue: code.code,
                  topPadding: 20,
                  leftPadding: 20,
                  bottomPadding: 20,
                  rightPadding: 20,
                  enabled: false,
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
                    child: DropdownButtonFormField<VoiceDTO>(
                      value: selectedVoz,
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
                      onChanged: (VoiceDTO? newValue) {
                        selectedVoz = newValue!;
                        ref.read(codesProviderProvider).createModifyCode =
                            code.copyWith(voice: selectedVoz);
                      },
                      items: [
                        ...voices
                            .map<DropdownMenuItem<VoiceDTO>>((VoiceDTO value) {
                          return DropdownMenuItem<VoiceDTO>(
                            value: value,
                            child: Text(
                              value.name,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                  ),
                  onPressed: () async {
                    await _selectDateTime(context);
                    await _selectTime();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            selectedDateTime != null
                                ? formatDateTime(selectedDateTime!, "dd/MM/yy")
                                : "Introducir fecha",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            selectedDateTime != null
                                ? formatDateTime(selectedDateTime!, "HH:mm")
                                : "de caducidad",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const Icon(Icons.calendar_month_outlined),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: CustomButton(
                  width: 250,
                  height: 60,
                  text: "Guardar",
                  color: "primary",
                  br: const BorderRadius.all(Radius.circular(16)),
                  onPressed: () {
                    if (ref
                        .read(codesProviderProvider)
                        .createModifyCode
                        .id
                        .isEmpty) {
                      ref.read(codesProviderProvider.notifier).createBandCode();
                    } else {
                      ref.read(codesProviderProvider.notifier).updateBandCode();
                    }
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
