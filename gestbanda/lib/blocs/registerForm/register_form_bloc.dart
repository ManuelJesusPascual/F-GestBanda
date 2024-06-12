import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gestbanda/blocs/registerForm/register_form_bloc_events.dart';
import 'package:gestbanda/blocs/registerForm/register_form_bloc_state.dart';
import 'package:gestbanda/models/BlocFormItem.dart';
import 'package:gestbanda/utils/extensions.dart';

class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  RegisterFormBloc() : super(const RegisterFormState()) {
    on<InitEvent>(_initRegisterFormState);
    on<NameChangedEvent>(_onNameChanged);
    on<EmailChangedEvent>(_onEmailChanged);
    on<PhoneChangedEvent>(_onPhoneChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<ConfirmPasswordChangedEvent>(_onConfirmPasswordChanged);
    on<FormSubmitEvent>(_onFormSubmitted);
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _initRegisterFormState(
      InitEvent event, Emitter<RegisterFormState> emitter) async {
    emit(state.copyWith(formKey: _formKey)); //TODO: Revisar
  }

  Future<void> _onNameChanged(
      NameChangedEvent event, Emitter<RegisterFormState> emitter) async {
    print("Nombre changed " + event.name.value);

    emit(state.copyWith(
        formKey: _formKey,
        name: BlocFormItem(
            value: event.name.value,
            error: event.name.value.isValidName
                ? null
                : "Introduce un nombre válido")));
  }

  Future<void> _onEmailChanged(
      EmailChangedEvent event, Emitter<RegisterFormState> emitter) async {
    print("Email changed " + event.email.value);
    emit(state.copyWith(
        formKey: _formKey,
        email: BlocFormItem(
            value: event.email.value,
            error: event.email.value.isValidEmail
                ? null
                : "Introduce un email válido")));
  }

  Future<void> _onPhoneChanged(
      PhoneChangedEvent event, Emitter<RegisterFormState> emitter) async {
    emit(state.copyWith(
        formKey: _formKey,
        phone: BlocFormItem(
            value: event.phone.value,
            error: event.phone.value.isValidPhone
                ? null
                : "Introduce un teléfono válido")));
  }

  Future<void> _onPasswordChanged(
      PasswordChangedEvent event, Emitter<RegisterFormState> emitter) async {
    emit(state.copyWith(
        formKey: _formKey,
        password: BlocFormItem(
            value: event.password.value,
            error: event.password.value.isValidPassword
                ? null
                : "La contraseña debe tener 8 caracteres, mayúscula,\nminúscula, número y caracter especial")));
  }

  Future<void> _onConfirmPasswordChanged(ConfirmPasswordChangedEvent event,
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

  Future<void> _onFormSubmitted(
      FormSubmitEvent event, Emitter<RegisterFormState> emitter) async {
    bool submitStatus = false;
    if (_formKey.currentState!.validate()) {
      print("Formulario válido");
      submitStatus = true;
    } else {
      print("Formulario inválido");
      submitStatus = false;
    }
    emit(state.copyWith(formKey: _formKey, submitStatus: submitStatus));
  }
}
