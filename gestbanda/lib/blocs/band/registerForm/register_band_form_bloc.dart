import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/blocs/band/registerForm/register_band_bloc_events.dart';
import 'package:gestbanda/blocs/band/registerForm/register_band_form_bloc_state.dart';
import 'package:gestbanda/utils/extensions.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/BlocFormItem.dart';

class RegisterBandFormBloc
    extends Bloc<RegisterBandFormEvents, RegisterBandFormState> {
  RegisterBandFormBloc() : super(const RegisterBandFormState()) {
    on<RegisterBandFormInitEvent>(_initRegisterBandFormState);
    on<RegisterBandFormNameChangedEvent>(_onNameChanged);
    on<RegisterBandFormImgChangedEvent>(_onImgChanged);
    on<RegisterBandFromSubmitEvent>(_onSubmitBandForm);
  }

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  Future<void> _initRegisterBandFormState(RegisterBandFormInitEvent event,
      Emitter<RegisterBandFormState> emitter) async {
    emitter(state.copyWith(formKey: _formKey));
  }

  Future<void> _onNameChanged(RegisterBandFormNameChangedEvent event,
      Emitter<RegisterBandFormState> emitter) async {
    emitter(state.copyWith(
        formKey: _formKey,
        name: BlocFormItem(
            labelText: event.name.labelText,
            value: event.name.value,
            error: event.name.value.isValidName
                ? null
                : "No puedes introducir un nombre vacío")));
  }

//Solucionar que si se hace doble click en el boton se lanza excepcion, hacer loadingState
  Future<void> _onImgChanged(RegisterBandFormImgChangedEvent event,
      Emitter<RegisterBandFormState> emitter) async {
    if (!loading) {
      loading = true;
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnedImage != null) {
        emitter(
            state.copyWith(formKey: _formKey, img: File(returnedImage.path)));
      } else {
        emitter(state.copyWith(formKey: _formKey, img: null));
      }
      loading = false;
    }
  }

  Future<void> _onSubmitBandForm(RegisterBandFromSubmitEvent event,
      Emitter<RegisterBandFormState> emitter) async {
    if (!loading) {
      loading = true;
      bool submitStatus = false;
      if (_formKey.currentState!.validate() && state.img != null) {
        submitStatus = true;
      } else {
        submitStatus = false;
      }
      emitter(state.copyWith(formKey: _formKey, submitStatus: submitStatus));
      submitStatus = false;
      emitter(state.copyWith(formKey: _formKey, submitStatus: submitStatus));

      loading = false;
    }
  }
}
