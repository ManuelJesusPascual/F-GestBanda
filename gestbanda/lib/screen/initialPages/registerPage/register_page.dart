import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';
import '../../../widgets/widgets.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: GlobalKey<FormState>(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0, top: 40),
                    child: Text(
                      '¡Bienvenido!',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ).animate().fade(duration: 500.ms).scale(),
                  ),
                  Text(
                    "Por favor, introduce tus datos para crear una cuenta.",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ).animate().fade(duration: 500.ms).scale(),
                  CustomTextInput(
                    label: "Nombre",
                    hint: "Juan Rodriguez Perez",
                    topPadding: 20.0,
                    leftPadding: 40.0,
                    rightPadding: 40.0,
                    onChanged: (val) {},
                    validator: (val) {
                      return null;
                    },
                  ),
                  CustomTextInput(
                    label: "Email",
                    hint: "nombre@example.com",
                    keyboardType: TextInputType.emailAddress,
                    topPadding: 20.0,
                    leftPadding: 40.0,
                    rightPadding: 40.0,
                    onChanged: (val) {},
                    validator: (val) {
                      return null;
                    },
                  ),
                  CustomTextInput(
                    label: "Teléfono",
                    hint: "612345678",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9)
                    ],
                    topPadding: 20.0,
                    leftPadding: 40.0,
                    rightPadding: 40.0,
                    onChanged: (val) {},
                    validator: (val) {
                      return null;
                    },
                  ),
                  CustomTextInput(
                    label: "Contraseña",
                    hint: "**********",
                    obscure: true,
                    topPadding: 20.0,
                    leftPadding: 40.0,
                    rightPadding: 40.0,
                    onChanged: (val) {},
                    validator: (val) {
                      return null;
                    },
                  ),
                  CustomTextInput(
                    label: "Confirma tu contraseña",
                    hint: "**********",
                    obscure: true,
                    topPadding: 20.0,
                    leftPadding: 40.0,
                    rightPadding: 40.0,
                    onChanged: (val) {},
                    validator: (val) {
                      return null;
                    },
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: CustomButton(
                          text: "Registrarse",
                          color: "primary",
                          br: const BorderRadius.all(Radius.circular(16)),
                          onPressed: () {
                            ref
                                .read(appRouterProvider.notifier)
                                .changeRouter(authenticatedRouter);
                            ref.read(appRouterProvider).push("/");
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Al registrarte en gestbanda, estás aceptando nuestra",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextButton(
                          onPressed: () {
                            ref.read(appRouterProvider).push("/private_policy");
                          },
                          style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.primary,
                            textStyle: Theme.of(context).textTheme.bodySmall,
                            overlayColor: Colors.transparent,
                          ),
                          child: const Text(
                            "política de privacidad",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
