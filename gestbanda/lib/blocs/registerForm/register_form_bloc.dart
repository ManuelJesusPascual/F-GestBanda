import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gestbanda/blocs/registerForm/register_form_bloc_events.dart';
import 'package:gestbanda/blocs/registerForm/register_form_bloc_state.dart';
import 'package:gestbanda/models/BlocFormItem.dart';
import 'package:gestbanda/utils/extensions.dart';

class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  RegisterFormBloc() : super(const RegisterFormState()) {
    on<RegisterFormInitEvent>(_initRegisterFormState);
    on<RegisterFormNameChangedEvent>(_onNameChanged);
    on<RegisterFormEmailChangedEvent>(_onEmailChanged);
    on<RegisterFormPhoneChangedEvent>(_onPhoneChanged);
    on<RegisterFormPasswordChangedEvent>(_onPasswordChanged);
    on<RegisterFormConfirmPasswordChangedEvent>(_onConfirmPasswordChanged);
    on<RegisterFormFormSubmitEvent>(_onFormSubmitted);
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _initRegisterFormState(
      RegisterFormInitEvent event, Emitter<RegisterFormState> emitter) async {
    emit(state.copyWith(formKey: _formKey));
  }

  Future<void> _onNameChanged(RegisterFormNameChangedEvent event,
      Emitter<RegisterFormState> emitter) async {
    emit(state.copyWith(
        formKey: _formKey,
        name: BlocFormItem(
            value: event.name.value,
            error: event.name.value.isValidName
                ? null
                : "Introduce un nombre válido")));
  }

  Future<void> _onEmailChanged(RegisterFormEmailChangedEvent event,
      Emitter<RegisterFormState> emitter) async {
    emit(state.copyWith(
        formKey: _formKey,
        email: BlocFormItem(
            value: event.email.value,
            error: event.email.value.isValidEmail
                ? null
                : "Introduce un email válido")));
  }

  Future<void> _onPhoneChanged(RegisterFormPhoneChangedEvent event,
      Emitter<RegisterFormState> emitter) async {
    emit(state.copyWith(
        formKey: _formKey,
        phone: BlocFormItem(
            value: event.phone.value,
            error: event.phone.value.isValidPhone
                ? null
                : "Introduce un teléfono válido")));
  }

  Future<void> _onPasswordChanged(RegisterFormPasswordChangedEvent event,
      Emitter<RegisterFormState> emitter) async {
    emit(state.copyWith(
        formKey: _formKey,
        password: BlocFormItem(
            value: event.password.value,
            error: event.password.value.isValidPassword
                ? null
                : "La contraseña debe tener 8 caracteres, mayúscula,\nminúscula, número y caracter especial")));
  }

  Future<void> _onConfirmPasswordChanged(
      RegisterFormConfirmPasswordChangedEvent event,
      Emitter<RegisterFormState> emitter) async {
    emit(state.copyWith(
        formKey: _formKey,
        confirmPassword: BlocFormItem(
            value: event.confirmPassword.value,
            error: event.confirmPassword.value
                    .isValidConfirmPassword(event.password)
                ? null
                : "Las contraseñas deben coincidir")));
  }

  Future<void> _onFormSubmitted(RegisterFormFormSubmitEvent event,
      Emitter<RegisterFormState> emitter) async {
    //TODO: Cambiar por lógica que llame a la BBDD y registre a un usuario, tras eso almacenarlo en localStorage o donde sea que se alamacena en flutter

    bool submitStatus = false;
    if (_formKey.currentState!.validate()) {
      submitStatus = true;
    } else {
      submitStatus = false;
    }
    emit(state.copyWith(formKey: _formKey, submitStatus: submitStatus));
  }
}
