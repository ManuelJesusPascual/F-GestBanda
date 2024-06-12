import 'package:equatable/equatable.dart';
import 'package:gestbanda/models/BlocFormItem.dart';

abstract class RegisterFormEvent extends Equatable {
  const RegisterFormEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends RegisterFormEvent {
  const InitEvent();
}

class NameChangedEvent extends RegisterFormEvent {
  const NameChangedEvent({required this.name});
  final BlocFormItem name;
  @override
  List<Object> get props => [name];
}

class EmailChangedEvent extends RegisterFormEvent {
  const EmailChangedEvent({required this.email});
  final BlocFormItem email;
  @override
  List<Object> get props => [email];
}

class PhoneChangedEvent extends RegisterFormEvent {
  const PhoneChangedEvent({required this.phone});
  final BlocFormItem phone;
  @override
  List<Object> get props => [phone];
}

class PasswordChangedEvent extends RegisterFormEvent {
  const PasswordChangedEvent({required this.password});
  final BlocFormItem password;
  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChangedEvent extends RegisterFormEvent {
  const ConfirmPasswordChangedEvent(
      {required this.password, required this.confirmPassword});
  final String password;
  final BlocFormItem confirmPassword;
  @override
  List<Object> get props => [password, confirmPassword];
}

class FormSubmitEvent extends RegisterFormEvent {
  const FormSubmitEvent();
}
