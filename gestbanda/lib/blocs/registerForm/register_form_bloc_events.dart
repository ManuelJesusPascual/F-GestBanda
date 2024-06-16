import 'package:equatable/equatable.dart';
import 'package:gestbanda/models/BlocFormItem.dart';

abstract class RegisterFormEvent extends Equatable {
  const RegisterFormEvent();

  @override
  List<Object> get props => [];
}

class RegisterFormInitEvent extends RegisterFormEvent {
  const RegisterFormInitEvent();
}

class RegisterFormNameChangedEvent extends RegisterFormEvent {
  const RegisterFormNameChangedEvent({required this.name});
  final BlocFormItem name;
  @override
  List<Object> get props => [name];
}

class RegisterFormEmailChangedEvent extends RegisterFormEvent {
  const RegisterFormEmailChangedEvent({required this.email});
  final BlocFormItem email;
  @override
  List<Object> get props => [email];
}

class RegisterFormPhoneChangedEvent extends RegisterFormEvent {
  const RegisterFormPhoneChangedEvent({required this.phone});
  final BlocFormItem phone;
  @override
  List<Object> get props => [phone];
}

class RegisterFormPasswordChangedEvent extends RegisterFormEvent {
  const RegisterFormPasswordChangedEvent({required this.password});
  final BlocFormItem password;
  @override
  List<Object> get props => [password];
}

class RegisterFormConfirmPasswordChangedEvent extends RegisterFormEvent {
  const RegisterFormConfirmPasswordChangedEvent(
      {required this.password, required this.confirmPassword});
  final String password;
  final BlocFormItem confirmPassword;
  @override
  List<Object> get props => [password, confirmPassword];
}

class RegisterFormFormSubmitEvent extends RegisterFormEvent {
  const RegisterFormFormSubmitEvent();
}
