import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/domain/newmodels/roleModels/role_dto.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:gestbanda/presentation/providers/rolesProvider/roles_provider.dart';
import 'package:gestbanda/presentation/providers/userBandProvider/user_band_provider.dart';
import 'package:gestbanda/widgets/widgets.dart';

import '../../../../domain/newmodels/voiceModels/voice_dto.dart';
import '../../../providers/voicesProvider/voices_provider.dart';

class EditUserDetailPage extends ConsumerStatefulWidget {
  const EditUserDetailPage({super.key, required this.user});

  final UserDTO user;

  @override
  ConsumerState<EditUserDetailPage> createState() => _EditUserDetailPageState();
}

class _EditUserDetailPageState extends ConsumerState<EditUserDetailPage> {
  bool isFirstLoad = true;
  @override
  void initState() {
    super.initState();
    // Cargar las listas desde los notifiers
    ref.read(voicesProviderProvider.notifier).getVoiceList();
    ref.read(rolesProviderProvider.notifier).getRolesList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userBandProviderProvider.notifier).updateUserModify(widget.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userBandState = ref.watch(userBandProviderProvider);
    UserDTO user = userBandState.userModify.copyWith();

    List<VoiceDTO> voices = ref.watch(voicesProviderProvider).bandVoices;
    List<RoleDTO> roles = ref.watch(rolesProviderProvider).roles;

    // Mostrar un indicador de carga si las listas están vacías
    if (voices.isEmpty || roles.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    VoiceDTO selectedVoz = voices.firstWhere(
      (voice) => voice.id == userBandState.userModify.voz!.id,
      orElse: () => voices.first,
    );

    RoleDTO selectedRol = roles.firstWhere(
      (rol) => rol.id == userBandState.userModify.role!.id,
      orElse: () => roles.first,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                userBandState.userModify.name,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const Text("Selecciona el rol del componente:"),
              DropdownButtonHideUnderline(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: DropdownButtonFormField<RoleDTO>(
                    value: selectedRol,
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
                    onChanged: (RoleDTO? newValue) {
                      if (newValue != null) {
                        user.role = newValue;
                      }
                    },
                    items:
                        roles.map<DropdownMenuItem<RoleDTO>>((RoleDTO value) {
                      return DropdownMenuItem<RoleDTO>(
                        value: value,
                        child: Text(
                          value.name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const Text("Selecciona la voz del componente:"),
              DropdownButtonHideUnderline(
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
                      if (newValue != null) {
                        user.voz = newValue;
                      }
                    },
                    items: voices
                        .map<DropdownMenuItem<VoiceDTO>>((VoiceDTO value) {
                      return DropdownMenuItem<VoiceDTO>(
                        value: value,
                        child: Text(
                          value.name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              CustomButton(
                color: "primary",
                onPressed: () async {
                  await ref
                      .read(userBandProviderProvider.notifier)
                      .modifyUserBand(user);
                },
                br: BorderRadius.circular(16),
                text: "Guardar",
              )
            ],
          ),
        ),
      ),
    );
  }
}
