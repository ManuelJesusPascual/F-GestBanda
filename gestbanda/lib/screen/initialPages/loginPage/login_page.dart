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
      body: BlocListener<LoginFormBloc, LoginFormState>(
        listener: (context, state) => {
          if (state.submitStatus)
            {
              context
                  .read<RouterSimpleCubit>()
                  .changeRouter(authenticatedRouter),
              context.read<RouterSimpleCubit>().pushRoute("/")
            }
        },
        child: BlocBuilder<LoginFormBloc, LoginFormState>(
          builder: (context, state) {
            return SafeArea(
              child: Center(
                heightFactor: 1.3,
                child: Form(
                  key: state.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0, top: 10),
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
                          label: state.email.labelText,
                          hint: state.email.hintText,
                          keyboardType: TextInputType.emailAddress,
                          topPadding: 20.0,
                          leftPadding: 40.0,
                          rightPadding: 40.0,
                          onChanged: (val) {
                            BlocProvider.of<LoginFormBloc>(context).add(
                                LoginFormEmailChangedEvent(
                                    email: BlocFormItem(value: val)));
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
                            BlocProvider.of<LoginFormBloc>(context).add(
                                LoginFormPasswordChangedEvent(
                                    password: BlocFormItem(value: val)));
                          },
                        ),
                        SizedBox(
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: CustomButton(
                                text: "Iniciar Sesión",
                                color: "primary",
                                br: const BorderRadius.all(Radius.circular(10)),
                                onPressed: () {
                                  BlocProvider.of<LoginFormBloc>(context)
                                      .add(const LoginFormSubmitEvent());
                                }),
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
