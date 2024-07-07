import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/models/BlocFormItem.dart';

import '../../../blocs/blocs.dart';
import '../../../config/config.dart';
import '../../../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocListener<LoginUserFormBloc, LoginUserFormState>(
        listener: (context, state) {
          if (state.submitStatus) {
            context.read<RouterSimpleCubit>().changeRouter(authenticatedRouter);
            context.read<RouterSimpleCubit>().pushRoute("/");
          }
        },
        child: BlocBuilder<LoginUserFormBloc, LoginUserFormState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Form(
                    key: state.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0, top: 10),
                          child: Text(
                            '¡Bienvenido de nuevo!',
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ).animate().fade(duration: 500.ms).scale(),
                        ),
                        Text(
                          "Por favor, inicia sesión con tus credenciales.",
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ).animate().fade(duration: 500.ms).scale(),
                        CustomTextInput(
                          label: state.email.labelText,
                          hint: state.email.hintText,
                          keyboardType: TextInputType.emailAddress,
                          topPadding: 20.0,
                          leftPadding: 40.0,
                          rightPadding: 40.0,
                          onChanged: (val) {
                            BlocProvider.of<LoginUserFormBloc>(context).add(
                                LoginUserFormEmailChangedEvent(
                                    email: BlocFormItem(
                                        value: val,
                                        labelText: state.email.labelText)));
                          },
                          validator: (val) {
                            return state.email.error;
                          },
                        ),
                        CustomTextInput(
                          label: state.password.labelText,
                          hint: state.password.hintText,
                          obscure: true,
                          topPadding: 20.0,
                          leftPadding: 40.0,
                          rightPadding: 40.0,
                          onChanged: (val) {
                            BlocProvider.of<LoginUserFormBloc>(context).add(
                                LoginUserFormPasswordChangedEvent(
                                    password: BlocFormItem(
                                        value: val,
                                        labelText: state.password.labelText)));
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
                                br: const BorderRadius.all(Radius.circular(10)),
                                onPressed: () {
                                  BlocProvider.of<LoginUserFormBloc>(context)
                                      .add(const LoginUserFormSubmitEvent());
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
            );
          },
        ),
      ),
    );
  }
}
