import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/presentation/providers/sharedPreferencesProvider/shared_preferences_provider.dart';

import '../config/config.dart';
import '../domain/newmodels/bandModels/band_dto.dart';

class Header extends ConsumerWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<String?>(
        future: ref
            .read(sharedPreferencesProviderProvider.notifier)
            .getString(key: 'band'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text("Error al cargar los datos"));
          } else {
            BandDTO band = BandDTO.fromJson(jsonDecode(snapshot.data!));
            return Row(
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    band.img!,
                    cacheManager: CacheManager(
                      Config(
                        band.img!,
                        stalePeriod: const Duration(days: 7),
                      ),
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  radius: 20,
                ),
                Expanded(
                  child: Text(
                    band.name,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      final router = await ref.read(appRouterProvider.future);

                      router.push("/settings");
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            );
          }
        });
  }
}
