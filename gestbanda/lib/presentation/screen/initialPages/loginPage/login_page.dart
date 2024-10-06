import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/presentation/providers/errorProvider/error_provider.dart';

import '../../../../widgets/widgets.dart';
import '../../../providers/loginProvider/login_provider.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginProvider = ref.watch(loginProviderProvider.notifier);
    final errorMessage = ref.watch(errorProviderProvider);

    if (errorMessage.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        );
        // Clear the error message after showing the snackbar
        ref.read(errorProviderProvider.notifier).setError("");
      });
    }

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, top: 10),
                      child: Text(
                        '¡Bienvenido de nuevo!',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      "Por favor, inicia sesión con tus credenciales.",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    CustomTextInput(
                        label: "Email",
                        hint: "nombre@example.com",
                        keyboardType: TextInputType.emailAddress,
                        topPadding: 20.0,
                        leftPadding: 40.0,
                        rightPadding: 40.0,
                        onChanged: (val) {
                          loginProvider.changeEmail(val);
                        },
                        validator: (val) {
                          return ref
                              .read(loginProviderProvider.notifier)
                              .validateEmail(val);
                        }),
                    CustomTextInput(
                      label: "Contraseña",
                      hint: "**********",
                      obscure: true,
                      topPadding: 20.0,
                      leftPadding: 40.0,
                      rightPadding: 40.0,
                      onChanged: (val) {
                        loginProvider.changePassword(val);
                      },
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: CustomButton(
                            text: "Iniciar Sesión",
                            color: "primary",
                            br: const BorderRadius.all(Radius.circular(16)),
                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {
                                ref
                                    .read(loginProviderProvider.notifier)
                                    .login();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
