import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gestbanda/models/BlocFormItem.dart';

class RegisterFormState extends Equatable {
  final BlocFormItem name;
  final BlocFormItem email;
  final BlocFormItem phone;
  final BlocFormItem password;
  final BlocFormItem confirmPassword;

  final GlobalKey<FormState>? formKey;

  const RegisterFormState(
      {this.name = const BlocFormItem(
          labelText: "Nombre",
          hintText: "Francisco Perez García",
          error: "Introduce un nombre válido"),
      this.email = const BlocFormItem(
          labelText: "Email",
          hintText: "nombre@example.com",
          error: "Introduce un email válido"),
      this.phone = const BlocFormItem(
          labelText: "Telefono",
          hintText: "633333333",
          error: "Introduce un teléfono válido"),
      this.password = const BlocFormItem(
          labelText: "Contraseña",
          error:
              "La contraseña debe tener 8 caracteres, mayúscula,\nminúscula, número y caracter especial"),
      this.confirmPassword = const BlocFormItem(
          labelText: "Confirma tu contraseña",
          error: "Las contraseñas deben coincidir"),
      this.formKey});

  RegisterFormState copyWith({
    BlocFormItem? name,
    BlocFormItem? email,
    BlocFormItem? phone,
    BlocFormItem? password,
    BlocFormItem? confirmPassword,
    GlobalKey<FormState>? formKey,
  }) {
    return RegisterFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      formKey: formKey ?? this.formKey,
    );
  }

  @override
  List<Object?> get props =>
      [name, email, phone, password, confirmPassword, formKey];
}
