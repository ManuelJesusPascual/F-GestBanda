import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gestbanda/widgets/costume_tile.dart';
import 'package:gestbanda/widgets/instrument_tile.dart';

import '../../../models/User.dart';
import '../../../utils/string_utilites.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Instrumentos del usuario:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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
                                  child: InstrumentTile(instrument: instrument),
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Uniforme del usuario:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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
                                  child: CostumeTile(costume: costume),
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
