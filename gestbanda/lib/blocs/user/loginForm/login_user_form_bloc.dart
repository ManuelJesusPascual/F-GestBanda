import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gestbanda/blocs/blocs.dart';
import 'package:gestbanda/models/BlocFormItem.dart';
import 'package:gestbanda/utils/extensions.dart';

class LoginUserFormBloc extends Bloc<LoginUserFormEvent, LoginUserFormState> {
  LoginUserFormBloc() : super(const LoginUserFormState()) {
    on<LoginFormInitEvent>(_initLoginFormState);
    on<LoginFormEmailChangedEvent>(_onEmailChanged);
    on<LoginFormPasswordChangedEvent>(_onPasswordChanged);
    on<LoginFormSubmitEvent>(_onFormSubmitted);
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _initLoginFormState(
      LoginFormInitEvent event, Emitter<LoginUserFormState> emitter) async {
    emit(state.copyWith(formKey: _formKey));
  }

  Future<void> _onEmailChanged(LoginFormEmailChangedEvent event,
      Emitter<LoginUserFormState> emitter) async {
    emit(state.copyWith(
        formKey: _formKey,
        email: BlocFormItem(
            value: event.email.value,
            error: event.email.value.isValidEmail
                ? null
                : "Introduce un email válido")));
  }

  Future<void> _onPasswordChanged(LoginFormPasswordChangedEvent event,
      Emitter<LoginUserFormState> emitter) async {
    emit(state.copyWith(
        formKey: _formKey,
        password: BlocFormItem(
          value: event.password.value,
        )));
  }

  Future<void> _onFormSubmitted(
      LoginFormSubmitEvent event, Emitter<LoginUserFormState> emitter) async {
    //TODO: Cambiar por lógica que llame a la BBDD y loguee a un usuario, tras eso almacenarlo en localStorage o donde sea que se alamacena en flutter
    bool submitStatus = false;
    if (_formKey.currentState!.validate()) {
      submitStatus = true;
    } else {
      submitStatus = false;
    }
    emit(state.copyWith(formKey: _formKey, submitStatus: submitStatus));
  }
}
