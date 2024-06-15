import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/widgets/widgets.dart';

import '../../config/config.dart';

class RegisterSelectorPage extends StatelessWidget {
  const RegisterSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 90, bottom: 30.0),
          child: Text(
            'Selecciona una opción',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ).animate().fade(duration: 500.ms).scale(),
        ),
        Text(
          "Elige como quieres continuar con tu cuenta",
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ).animate().fade(duration: 500.ms).scale(),
        Center(
          heightFactor: 1.3,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomButton(
              text: "Registra tu propia banda",
              color: "primary",
              imgSvgAsset: "assets/svg/register_new_band.svg",
              imgHeight: 150,
              imgWidth: 150,
              onPressed: () {
                context.read<RouterSimpleCubit>().pushRoute("/create_band_one");
              },
              br: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              width: 180,
              height: 350,
            ),
            CustomButton(
              text: "Únete a una banda mediante un código",
              color: "secondary",
              imgSvgAsset: "assets/svg/join_to_band.svg",
              imgHeight: 150,
              imgWidth: 150,
              onPressed: () {
                context.read<RouterSimpleCubit>().pushRoute("/join_band");
              },
              br: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              width: 180,
              height: 350,
            )
          ]),
        ),
      ])),
    );
  }
}
