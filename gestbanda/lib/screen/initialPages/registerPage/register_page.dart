import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/models/bloc_form_item.dart';

import '../../../blocs/blocs.dart';
import '../../../config/config.dart';
import '../../../widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocListener<RegisterUserFormBloc, RegisterUserFormState>(
        listener: (context, state) {
          if (state.submitStatus) {
            context.read<RouterSimpleCubit>().changeRouter(authenticatedRouter);
            context.read<RouterSimpleCubit>().pushRoute("/");
          }
        },
        child: BlocBuilder<RegisterUserFormBloc, RegisterUserFormState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: state.formKey,
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
                        label: state.name.labelText,
                        hint: state.name.hintText,
                        topPadding: 20.0,
                        leftPadding: 40.0,
                        rightPadding: 40.0,
                        onChanged: (val) {
                          BlocProvider.of<RegisterUserFormBloc>(context).add(
                              RegisterUserFormNameChangedEvent(
                                  name: BlocFormItem(
                                      value: val,
                                      labelText: state.name.labelText)));
                        },
                        validator: (val) {
                          return state.name.error;
                        },
                      ),
                      CustomTextInput(
                        label: state.email.labelText,
                        hint: state.email.hintText,
                        keyboardType: TextInputType.emailAddress,
                        topPadding: 20.0,
                        leftPadding: 40.0,
                        rightPadding: 40.0,
                        onChanged: (val) {
                          BlocProvider.of<RegisterUserFormBloc>(context).add(
                              RegisterUserFormEmailChangedEvent(
                                  email: BlocFormItem(
                                      value: val,
                                      labelText: state.email.labelText)));
                        },
                        validator: (val) {
                          return state.email.error;
                        },
                      ),
                      CustomTextInput(
                        label: state.phone.labelText,
                        hint: state.phone.hintText,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(9)
                        ],
                        topPadding: 20.0,
                        leftPadding: 40.0,
                        rightPadding: 40.0,
                        onChanged: (val) {
                          BlocProvider.of<RegisterUserFormBloc>(context).add(
                              RegisterUserFormPhoneChangedEvent(
                                  phone: BlocFormItem(
                                      value: val,
                                      labelText: state.phone.labelText)));
                        },
                        validator: (val) {
                          return state.phone.error;
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
                          BlocProvider.of<RegisterUserFormBloc>(context).add(
                              RegisterUserFormPasswordChangedEvent(
                                  password: BlocFormItem(
                                      value: val,
                                      labelText: state.password.labelText)));
                        },
                        validator: (val) {
                          return state.password.error;
                        },
                      ),
                      CustomTextInput(
                        label: state.confirmPassword.labelText,
                        hint: state.confirmPassword.hintText,
                        obscure: true,
                        topPadding: 20.0,
                        leftPadding: 40.0,
                        rightPadding: 40.0,
                        onChanged: (val) {
                          BlocProvider.of<RegisterUserFormBloc>(context).add(
                              RegisterUserFormConfirmPasswordChangedEvent(
                                  password: state.password.value,
                                  confirmPassword: BlocFormItem(
                                      value: val,
                                      labelText:
                                          state.confirmPassword.labelText)));
                        },
                        validator: (val) {
                          return state.confirmPassword.error;
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
                                BlocProvider.of<RegisterUserFormBloc>(context)
                                    .add(
                                        const RegisterUserFormFormSubmitEvent());
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
                                context
                                    .read<RouterSimpleCubit>()
                                    .pushRoute("/private_policy");
                              },
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).colorScheme.primary,
                                textStyle:
                                    Theme.of(context).textTheme.bodySmall,
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
            );
          },
        ),
      ),
    );
  }
}
