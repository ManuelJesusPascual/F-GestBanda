import 'package:equatable/equatable.dart';
import 'package:gestbanda/models/BlocFormItem.dart';

abstract class RegisterUserFormEvent extends Equatable {
  const RegisterUserFormEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserFormInitEvent extends RegisterUserFormEvent {
  const RegisterUserFormInitEvent();
}

class RegisterUserFormNameChangedEvent extends RegisterUserFormEvent {
  const RegisterUserFormNameChangedEvent({required this.name});
  final BlocFormItem name;
  @override
  List<Object> get props => [name];
}

class RegisterUserFormEmailChangedEvent extends RegisterUserFormEvent {
  const RegisterUserFormEmailChangedEvent({required this.email});
  final BlocFormItem email;
  @override
  List<Object> get props => [email];
}

class RegisterUserFormPhoneChangedEvent extends RegisterUserFormEvent {
  const RegisterUserFormPhoneChangedEvent({required this.phone});
  final BlocFormItem phone;
  @override
  List<Object> get props => [phone];
}

class RegisterUserFormPasswordChangedEvent extends RegisterUserFormEvent {
  const RegisterUserFormPasswordChangedEvent({required this.password});
  final BlocFormItem password;
  @override
  List<Object> get props => [password];
}

class RegisterUserFormConfirmPasswordChangedEvent
    extends RegisterUserFormEvent {
  const RegisterUserFormConfirmPasswordChangedEvent(
      {required this.password, required this.confirmPassword});
  final String password;
  final BlocFormItem confirmPassword;
  @override
  List<Object> get props => [password, confirmPassword];
}

class RegisterUserFormFormSubmitEvent extends RegisterUserFormEvent {
  const RegisterUserFormFormSubmitEvent();
}
