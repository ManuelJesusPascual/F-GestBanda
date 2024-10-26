import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/presentation/providers/sharedPreferencesProvider/shared_preferences_provider.dart';
import 'package:gestbanda/widgets/widgets.dart';

import '../../../../config/config.dart';
import '../../../../domain/models/band.dart';
import '../../../../domain/models/user.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Ajustes",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                leading: const CircleAvatar(
                  child: Text("MJ"),
                ),
                title: const Text("Ajustes de Usuario"),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                onTap: () async {
                  final router = await ref.read(appRouterProvider.future);

                  router.push(
                    "/user_settings",
                    extra: User(
                        name: "Usuario de ejemplo",
                        email: "support@gestbanda.com",
                        phone: "666666666",
                        role: "Componente",
                        voz: "Corneta",
                        instrumentList: [],
                        costumeList: []),
                  );
                },
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/logoBanda.png"),
                  backgroundColor: Colors.transparent,
                ),
                title: const Text("Ajustes de Banda"),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                onTap: () async {
                  final router = await ref.read(appRouterProvider.future);

                  router.push("/band_settings",
                      extra: Band(
                          name: "Banda Municipal de Villaejemplo",
                          suscription: "Suscripcion Anual"));
                },
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 25),
                child: CustomButton(
                    color: "error",
                    height: 75,
                    width: 250,
                    br: BorderRadius.circular(16),
                    text: "Salir de la banda",
                    onPressed: () async {
                      ref
                          .read(sharedPreferencesProviderProvider.notifier)
                          .removeString(key: "band");
                      ref
                          .read(appRouterProvider.notifier)
                          .changeRouter(authenticatedRouter);
                      final router = await ref.read(appRouterProvider.future);

                      router.go("/");
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
