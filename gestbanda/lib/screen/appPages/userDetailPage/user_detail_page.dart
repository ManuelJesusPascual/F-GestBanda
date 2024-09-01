import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/widgets/costume_tile.dart';
import 'package:gestbanda/widgets/instrument_tile.dart';

import '../../../config/config.dart';
import '../../../models/user.dart';
import '../../../utils/string_utilites.dart';

class UserDetailPage extends ConsumerWidget {
  const UserDetailPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit,
                color: Theme.of(context).colorScheme.onSurface),
            onPressed: () {
              ref.read(appRouterProvider).push("/user_modify", extra: user);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.error,
        onPressed: () {},
        child: Icon(
          Icons.delete_forever,
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
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
                "${user.role} · ${user.voz}",
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
                          onPressed: () {
                            ref.read(appRouterProvider).push(
                                  "/user_add_instrument",
                                );
                          },
                        ),
                      ],
                    ),
                    user.instrumentList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: user.instrumentList.length,
                              itemBuilder: (context, index) {
                                final instrument = user.instrumentList[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: InstrumentTile(
                                    instrument: instrument,
                                    onPressed: () {
                                      ref.read(appRouterProvider).push(
                                          "/user_instrument_modify",
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
                          onPressed: () {
                            ref.read(appRouterProvider).push(
                                  "/user_add_costume",
                                );
                          },
                        ),
                      ],
                    ),
                    user.costumeList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: user.costumeList.length,
                              itemBuilder: (context, index) {
                                final costume = user.costumeList[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 16),
                                  child: CostumeTile(
                                    costume: costume,
                                    onPressed: () {
                                      ref.read(appRouterProvider).push(
                                          "/user_costume_modify",
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
