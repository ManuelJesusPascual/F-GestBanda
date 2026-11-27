import 'package:gestbanda/presentation/providers/bandPermissionsProvider/band_permissions_provider.dart';
import 'package:gestbanda/domain/newmodels/roleModels/band_permissions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:gestbanda/presentation/providers/userBandProvider/user_band_provider.dart';
import 'package:gestbanda/widgets/costume_tile.dart';
import 'package:gestbanda/widgets/instrument_tile.dart';

import '../../../../config/config.dart';
import '../../../../utils/string_utilites.dart';

class UserDetailPage extends ConsumerWidget {
  const UserDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserDTO user = ref.watch(userBandProviderProvider).userModify;
    final permissions =
        ref.watch(bandPermissionsProvider).valueOrNull ?? BandPermissions.none;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        actions: [
          if (permissions.canManageMember(user))
            IconButton(
              icon: Icon(Icons.edit,
                  color: Theme.of(context).colorScheme.onSurface),
              onPressed: () async {
                final router = await ref.read(appRouterProvider.future);

                await router.push("/user_modify", extra: user);
              },
            ),
        ],
      ),
      floatingActionButton: user.id !=
                  ref.watch(userBandProviderProvider).user.id &&
              permissions.canManageMember(user)
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.error,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "¿Estas seguro?",
                          textAlign: TextAlign.center,
                        ),
                        Text(user.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary))
                      ],
                    ),
                    icon: const Icon(Icons.delete, color: Colors.red),
                    content: const Text(
                      "¿Estás seguro de que deseas eliminar este usuario de tu banda?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Cerrar el diálogo
                        },
                        child: const Text(
                          "Cancelar",
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(userBandProviderProvider.notifier)
                              .removeUserBand();
                          Navigator.of(context).pop();
                        },
                        child: const Text("Eliminar",
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
              child: Icon(
                Icons.delete_forever,
                color: Theme.of(context).colorScheme.onError,
              ),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  backgroundImage: user.img != null
                      ? CachedNetworkImageProvider(
                          user.img!,
                          cacheManager: CacheManager(
                            Config(
                              user.img!,
                              stalePeriod: const Duration(days: 7),
                            ),
                          ),
                        )
                      : null,
                  radius: 65,
                  child: user.img != null
                      ? null
                      : Text(
                          getInitials(user.name),
                          style: const TextStyle(fontSize: 24),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                user.name,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "${user.role!.name} · ${user.voz!.name}",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Instrumentos del usuario:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.playlist_add),
                          onPressed: () async {
                            final router =
                                await ref.read(appRouterProvider.future);

                            router.push(
                              "/user_add_instrument",
                            );
                          },
                        ),
                      ],
                    ),
                    user.instrumentList!.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: user.instrumentList!.length,
                              itemBuilder: (context, index) {
                                final instrument = user.instrumentList![index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: InstrumentTile(
                                    instrument: instrument,
                                    onPressed: () async {
                                      final router = await ref
                                          .read(appRouterProvider.future);

                                      router.push("/user_instrument_modify",
                                          extra: instrument);
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            child: Text("No hay instrumentos asignados."),
                          ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Uniforme del usuario:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.playlist_add),
                          onPressed: () async {
                            final router =
                                await ref.read(appRouterProvider.future);

                            router.push(
                              "/user_add_costume",
                            );
                          },
                        ),
                      ],
                    ),
                    user.costumeList!.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: user.costumeList!.length,
                              itemBuilder: (context, index) {
                                final costume = user.costumeList![index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: CostumeTile(
                                    costume: costume,
                                    onPressed: () async {
                                      final router = await ref
                                          .read(appRouterProvider.future);

                                      router.push("/user_costume_modify",
                                          extra: costume);
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            child: Text("No hay partes del traje asignados"),
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
