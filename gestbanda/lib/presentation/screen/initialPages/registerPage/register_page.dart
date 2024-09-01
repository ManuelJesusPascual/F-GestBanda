import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/config.dart';
import '../../../../widgets/widgets.dart';
import "../../../../utils/extensions.dart";

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
                      if (val != null && val.isValidName) {
                        return null;
                      }
                      return "Debes introducir un nombre válido";
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
                      if (val != null && val.isValidEmail) {
                        return null;
                      }
                      return "Debes introducir un email válido";
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
                      if (val != null && val.isValidPhone) {
                        return null;
                      }
                      return "Debes introducir un teléfono válido";
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
                      if (val != null && !val.isValidPasswordLength) {
                        return "La contraseña debe tener al menos 8 caracteres";
                      } else if (val != null && !val.isValidPasswordMayus) {
                        return "La contraseña debe tener al menos una letra mayúscula";
                      } else if (val != null && !val.isValidPasswordMinus) {
                        return "La contraseña debe tener al menos una letra minúscula";
                      } else if (val != null && !val.isValidPasswordNumber) {
                        return "La contraseña debe tener al menos un número";
                      } else if (val != null &&
                          !val.isValidPasswordSpecialCharacters) {
                        return "La contraseña debe tener al menos un caracter especial";
                      } else if (val != null && val.isValidPassword) {
                        return null;
                      }
                      return "Debes introducir una contraseña válida";
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
                      if (val != null && val.isValidConfirmPassword(val)) {
                        //val.isValidConfirmPassword(ref), pero como ref aun falta por implementar se pone val
                        return null;
                      }
                      return "Las contrasenias no coinciden";
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
