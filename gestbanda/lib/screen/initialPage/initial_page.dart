import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/config.dart';
import '../../widgets/widgets.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              // Wrap SvgPicture.asset with Flexible widget
              child: SvgPicture.asset(
                "assets/svg/initial_screen.svg",
                width: 300,
                height: 300,
                semanticsLabel: "Imagen de una persona tocando la trompeta",
              ),
            ).animate().fade(duration: 800.ms).scale(),
            Text(
              '¡Gestiona tu banda \n en unos simples pasos!',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ).animate().fade(duration: 800.ms).scale(),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Trajes, componentes, instrumentos, salidas \n ¡Y mucho mas!",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ).animate().fade(duration: 800.ms).scale(),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: "Iniciar Sesion",
                  color: "primary",
                  br: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  onPressed: () {
                    print("Iniciar Sesion");
                  },
                ),
                CustomButton(
                  text: "Registrarse",
                  color: "secondary",
                  br: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  onPressed: () {
                    context
                        .read<RouterSimpleCubit>()
                        .pushRoute("/registerScreen");
                  },
                ),
              ],
            ).animate().fade(duration: 800.ms).scale(),
          ],
        ),
      ),
    );
  }
}
