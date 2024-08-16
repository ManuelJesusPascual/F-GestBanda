import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../config/config.dart';
import '../../../models/band.dart';
import '../../../utils/string_utilites.dart';

class BandSettingsPage extends StatelessWidget {
  const BandSettingsPage({super.key, required this.band});
  final Band band;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Ajustes de:",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Text(
                band.name,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Cambiar logo",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
                backgroundImage: band.img != null
                    ? CachedNetworkImageProvider(
                        band.img!,
                        cacheManager: CacheManager(
                          Config(
                            band.img!,
                            stalePeriod: const Duration(days: 7),
                          ),
                        ),
                      )
                    : null,
                radius: 50,
                child: band.img != null ? null : Text(getInitials(band.name)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cambiar nombre",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    band.name,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                context.read<RouterSimpleCubit>().pushRoute(
                      "/edit_band_setting/Nombre",
                      extra: band,
                    );
              },
            ),
            const Divider(
              indent: 16,
              endIndent: 8,
            ),
            const SizedBox(
              height: 15,
            ),
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cambiar suscripcion",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    band.suscription,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {},
            ),
            const Divider(
              indent: 16,
              endIndent: 8,
            ),
          ],
        ),
      )),
    );
  }
}
