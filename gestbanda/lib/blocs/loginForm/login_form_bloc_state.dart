import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gestbanda/models/BlocFormItem.dart';

class LoginFormState extends Equatable {
  final BlocFormItem email;
  final BlocFormItem password;

  final bool submitStatus;

  final GlobalKey<FormState>? formKey;

  const LoginFormState(
      {this.email = const BlocFormItem(
          labelText: "Email",
          hintText: "nombre@example.com",
          error: "Introduce un email válido"),
      this.password = const BlocFormItem(
        labelText: "Contraseña",
      ),
      this.submitStatus = false,
      this.formKey});

  LoginFormState copyWith({
    BlocFormItem? email,
    BlocFormItem? password,
    bool? submitStatus,
    GlobalKey<FormState>? formKey,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      submitStatus: submitStatus ?? this.submitStatus,
      formKey: formKey ?? this.formKey,
    );
  }

  @override
  List<Object?> get props => [email, password, submitStatus, formKey];
}
