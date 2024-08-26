import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../models/bloc_form_item.dart';

class RegisterBandFormState extends Equatable {
  final BlocFormItem name;
  final File? img;

  final bool submitStatus;
  final bool imgSelected;
  final GlobalKey<FormState>? formKey;

  const RegisterBandFormState(
      {this.name = const BlocFormItem(
          labelText: "Nombre de la banda",
          hintText: "Banda Municipal de Villaejemplo",
          error: "No puedes introducir un nombre vacío"),
      this.img,
      this.submitStatus = false,
      this.imgSelected = true,
      this.formKey});

  RegisterBandFormState copyWith({
    BlocFormItem? name,
    File? img,
    bool? submitStatus,
    bool? imgSelected,
    GlobalKey<FormState>? formKey,
  }) {
    return RegisterBandFormState(
      name: name ?? this.name,
      img: img ?? this.img,
      submitStatus: submitStatus ?? this.submitStatus,
      imgSelected: imgSelected ?? this.imgSelected,
      formKey: formKey ?? this.formKey,
    );
  }

  @override
  List<Object?> get props => [name, img, submitStatus, imgSelected, formKey];
}
