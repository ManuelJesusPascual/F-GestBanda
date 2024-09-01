import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/config/router/routes_config.dart';

import '../../../widgets/widgets.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Form(
                key: GlobalKey<FormState>(),
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
