import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/blocs/registerForm/register_form_bloc_events.dart';
import 'package:gestbanda/models/BlocFormItem.dart';

import '../../blocs/blocs.dart';
import '../../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<RegisterFormBloc, RegisterFormState>(
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: Form(
                key: state.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
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
                        topPadding: 30.0,
                        leftPadding: 40.0,
                        rightPadding: 40.0,
                        onChanged: (val) {
                          BlocProvider.of<RegisterFormBloc>(context).add(
                              NameChangedEvent(name: BlocFormItem(value: val)));
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
                          BlocProvider.of<RegisterFormBloc>(context).add(
                              EmailChangedEvent(
                                  email: BlocFormItem(value: val)));
                        },
                        validator: (val) {
                          return state.email.error;
                        },
                      ),
                      CustomTextInput(
                        label: state.phone.labelText,
                        hint: state.phone.hintText,
                        keyboardType: TextInputType.number,
                        topPadding: 20.0,
                        leftPadding: 40.0,
                        rightPadding: 40.0,
                        onChanged: (val) {
                          BlocProvider.of<RegisterFormBloc>(context).add(
                              PhoneChangedEvent(
                                  phone: BlocFormItem(value: val)));
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
                          BlocProvider.of<RegisterFormBloc>(context).add(
                              PasswordChangedEvent(
                                  password: BlocFormItem(value: val)));
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
                          BlocProvider.of<RegisterFormBloc>(context).add(
                              ConfirmPasswordChangedEvent(
                                  password: state.password.value,
                                  confirmPassword: BlocFormItem(value: val)));
                        },
                        validator: (val) {
                          return state.confirmPassword.error;
                        },
                      ),
                      SizedBox(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: CustomButton(
                              text: "Registarse",
                              color: "primary",
                              br: const BorderRadius.all(Radius.circular(10)),
                              onPressed: () async {
                                BlocProvider.of<RegisterFormBloc>(context)
                                    .add(const FormSubmitEvent());
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
