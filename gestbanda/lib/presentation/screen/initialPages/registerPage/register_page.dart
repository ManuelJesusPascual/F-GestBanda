import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/presentation/providers/errorProvider/error_provider.dart';
import 'package:gestbanda/presentation/providers/registerProvider/register_provider.dart';

import '../../../../config/config.dart';
import '../../../../widgets/widgets.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); // It's not recommended to put this in Riverpod

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerProvider = ref.watch(registerProviderProvider.notifier);
    final errorMessage = ref.watch(errorProviderProvider);

    if (errorMessage.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              locale: const Locale('es', 'ES'),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        );
        // Clear the error message after showing the snackbar
        ref.read(errorProviderProvider.notifier).setError("");
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(children: [
        SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0, top: 40),
                    child: Text(
                      '¡Bienvenido!',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "Por favor, introduce tus datos para crear una cuenta.",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  CustomTextInput(
                    label: "Nombre",
                    hint: "Juan Rodriguez Perez",
                    initalValue: ref.watch(registerProviderProvider).name,
                    topPadding: 20.0,
                    leftPadding: 40.0,
                    rightPadding: 40.0,
                    onChanged: (val) {
                      registerProvider.changeName(val);
                    },
                    validator: (val) {
                      return ref
                          .read(registerProviderProvider.notifier)
                          .validateName(val);
                    },
                  ),
                  CustomTextInput(
                    label: "Email",
                    hint: "nombre@example.com",
                    initalValue: ref.watch(registerProviderProvider).email,
                    keyboardType: TextInputType.emailAddress,
                    topPadding: 20.0,
                    leftPadding: 40.0,
                    rightPadding: 40.0,
                    onChanged: (val) {
                      registerProvider.changeEmail(val);
                    },
                    validator: (val) {
                      return ref
                          .read(registerProviderProvider.notifier)
                          .validateEmail(val);
                    },
                  ),
                  CustomTextInput(
                    label: "Teléfono",
                    hint: "612345678",
                    prefixText: "+34 ",
                    initalValue: ref.watch(registerProviderProvider).phone,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9)
                    ],
                    topPadding: 20.0,
                    leftPadding: 40.0,
                    rightPadding: 40.0,
                    onChanged: (val) {
                      registerProvider.changePhone(val);
                    },
                    validator: (val) {
                      return ref
                          .read(registerProviderProvider.notifier)
                          .validatePhone(val);
                    },
                  ),
                  CustomTextInput(
                    label: "Contraseña",
                    hint: "**********",
                    tooltipText:
                        "Usa mayúsculas, minúsculas, números, un carácter especial y al menos 8 caracteres.",
                    initalValue: ref.watch(registerProviderProvider).password,
                    suffixIcon:
                        ref.watch(passwordVisibilityProvider.notifier).icon,
                    suffixButton: () {
                      ref.read(passwordVisibilityProvider.notifier).toggle();
                    },
                    obscure: ref.watch(passwordVisibilityProvider),
                    topPadding: 20.0,
                    leftPadding: 40.0,
                    rightPadding: 40.0,
                    onChanged: (val) {
                      registerProvider.changePassword(val);
                    },
                    validator: (val) {
                      return ref
                          .read(registerProviderProvider.notifier)
                          .validatePassword(val);
                    },
                  ),
                  CustomTextInput(
                    label: "Confirma tu contraseña",
                    hint: "**********",
                    initalValue:
                        ref.watch(registerProviderProvider).confirmPassword,
                    obscure: ref.watch(passwordVisibilityProvider),
                    topPadding: 10.0,
                    leftPadding: 40.0,
                    rightPadding: 40.0,
                    onChanged: (val) {
                      registerProvider.changeConfirmPassword(val);
                    },
                    validator: (val) {
                      return ref
                          .read(registerProviderProvider.notifier)
                          .validateConfirmPassword(val);
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
                            if (formKey.currentState?.validate() ?? false) {
                              ref
                                  .read(registerProviderProvider.notifier)
                                  .register();
                            }
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
                          onPressed: () async {
                            final router =
                                await ref.read(appRouterProvider.future);
                            router.push("/private_policy");
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
        ),
        if (registerProvider.isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }
}
