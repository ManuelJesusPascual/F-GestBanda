import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/widgets/widgets.dart';

import '../../config/config.dart';

class RegisterSelectorPage extends ConsumerWidget {
  const RegisterSelectorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                  ),
                  onPressed: () {
                    ref
                        .read(appRouterProvider.notifier)
                        .changeRouter(unauthenticatedRouter);
                  },
                  child: const Icon(Icons.logout_outlined),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20.0),
                child: Text(
                  'Selecciona una opción',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ).animate().fade(duration: 500.ms).scale(),
              ),
              Text(
                "Elige cómo quieres continuar con tu cuenta",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ).animate().fade(duration: 500.ms).scale(),
              const SizedBox(height: 120),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: "Registra tu propia banda",
                    color: "primary",
                    imgSvgAsset: "assets/svg/register_new_band.svg",
                    imgHeight: 150,
                    imgWidth: 150,
                    onPressed: () {
                      ref.read(appRouterProvider).push("/create_band_one");
                    },
                    br: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    width: 160,
                    height: 300,
                  ),
                  CustomButton(
                    text: "Únete a una banda mediante un código",
                    color: "secondary",
                    imgSvgAsset: "assets/svg/join_to_band.svg",
                    imgHeight: 150,
                    imgWidth: 150,
                    onPressed: () {
                      ref.read(appRouterProvider).push("/join_band");
                    },
                    br: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    width: 160,
                    height: 300,
                  )
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
