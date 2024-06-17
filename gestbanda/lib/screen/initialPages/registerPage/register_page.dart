import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/models/BlocFormItem.dart';

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
        listener: (context, state) => {
          if (state.submitStatus)
            {
              context
                  .read<RouterSimpleCubit>()
                  .changeRouter(authenticatedRouter),
              context.read<RouterSimpleCubit>().pushRoute("/")
            }
        },
        child: BlocBuilder<RegisterUserFormBloc, RegisterUserFormState>(
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
                          label: state.name.labelText,
                          hint: state.name.hintText,
                          topPadding: 30.0,
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
                        SizedBox(
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: CustomButton(
                                text: "Registarse",
                                color: "primary",
                                br: const BorderRadius.all(Radius.circular(10)),
                                onPressed: () {
                                  BlocProvider.of<RegisterUserFormBloc>(context)
                                      .add(
                                          const RegisterUserFormFormSubmitEvent());
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
