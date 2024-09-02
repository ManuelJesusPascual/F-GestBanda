import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/config.dart';
import '../../../../domain/models/user.dart';
import '../../../../utils/string_utilites.dart';

class UserSettingsPage extends ConsumerWidget {
  const UserSettingsPage({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Ajustes de:\n ${user.name}",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Cambiar imagen de perfil",
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
                radius: 50,
                child: user.img != null ? null : Text(getInitials(user.name)),
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
                    user.name,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () async {
                final router = await ref.read(appRouterProvider.future);
                router.push("/edit_user_setting/Nombre", extra: user);
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
                    "Cambiar correo electrónico",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () async {
                final router = await ref.read(appRouterProvider.future);
                router.push("/edit_user_setting/Email", extra: user);
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
                    "Cambiar contraseña",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "**************",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () async {
                final router = await ref.read(appRouterProvider.future);
                router.push("/edit_user_setting/Contraseña", extra: user);
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
                    "Cambiar teléfono",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    user.phone,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () async {
                final router = await ref.read(appRouterProvider.future);

                router.push(
                  "/edit_user_setting/Telefono",
                  extra: user,
                );
              },
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
