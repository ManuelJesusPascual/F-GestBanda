import 'package:gestbanda/presentation/providers/bandPermissionsProvider/band_permissions_provider.dart';
import 'package:gestbanda/domain/newmodels/roleModels/band_permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:gestbanda/domain/newmodels/voiceModels/voice_dto.dart';
import 'package:gestbanda/presentation/providers/userBandProvider/user_band_provider.dart';
import 'package:gestbanda/presentation/providers/voicesProvider/voices_provider.dart';
import 'package:gestbanda/utils/extensions.dart';

import '../../../../config/config.dart';
import '../../../../widgets/widgets.dart';

class UserList extends ConsumerStatefulWidget {
  const UserList({super.key});

  @override
  ConsumerState<UserList> createState() => _UserListState();
}

class _UserListState extends ConsumerState<UserList> {
  bool isFirstLoad = true;

  String _selectedInstrument = 'Seleccionar Voz';

  @override
  Widget build(BuildContext context) {
    final permissions =
        ref.watch(bandPermissionsProvider).valueOrNull ?? BandPermissions.none;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (isFirstLoad) {
        await ref.watch(voicesProviderProvider.notifier).getVoiceList();
        await ref.watch(userBandProviderProvider.notifier).getUserBands();
        isFirstLoad = false;
      }
    });

    final List<UserDTO> users = ref
        .watch(userBandProviderProvider)
        .userBands
        .map((userBand) => userBand.toUser())
        .toList();

    List<UserDTO> filteredUsers = _selectedInstrument == 'Seleccionar Voz'
        ? users
        : users.where((user) => user.voz!.name == _selectedInstrument).toList();

    if (_selectedInstrument == 'Seleccionar Voz') {
      filteredUsers.sort((a, b) => a.voz!.name.compareTo(b.voz!.name));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: const MainBottomBar(currentIndex: 2),
      floatingActionButton: permissions.canManageCodes
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              onPressed: () async {
                final router = await ref.read(appRouterProvider.future);

                router.push("/code_list");
              },
              child: Icon(
                Icons.qr_code,
                color: Theme.of(context).colorScheme.surface,
              ),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              DropdownButtonHideUnderline(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: DropdownButtonFormField<String>(
                      value: "Seleccionar Voz",
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
                        setState(() {
                          _selectedInstrument = newValue!;
                        });
                      },
                      items: [
                        // Añade el valor predeterminado "Seleccionar Voz".
                        DropdownMenuItem<String>(
                          value: 'Seleccionar Voz',
                          child: Text(
                            "Seleccionar Voz",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.surface),
                          ),
                        ),
                        // Añade los valores obtenidos de voicesProviderProvider.
                        ...ref
                            .watch(voicesProviderProvider)
                            .bandVoices
                            .map<DropdownMenuItem<String>>((VoiceDTO value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(
                              value.name,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                          );
                        })
                      ]),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    UserDTO user = filteredUsers[index];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: UserTile(user: user),
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
