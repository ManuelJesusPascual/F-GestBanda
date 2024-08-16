import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config.dart';
import '../../../models/band.dart';
import '../../../models/user.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                onTap: () {
                  context.read<RouterSimpleCubit>().pushRoute(
                        "/user_settings",
                        extra: User(
                            name: "Usuario de ejemplo",
                            email: "support@gestbanda.com",
                            phone: "666666666",
                            role: "User",
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
                onTap: () {
                  context.read<RouterSimpleCubit>().pushRoute("/band_settings",
                      extra: Band(
                          name: "Banda Municipal de Villaejemplo",
                          suscription: "Suscripcion Anual"));
                },
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
