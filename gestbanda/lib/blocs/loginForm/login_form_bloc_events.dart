import 'package:equatable/equatable.dart';
import 'package:gestbanda/models/BlocFormItem.dart';

abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

class LoginFormInitEvent extends LoginFormEvent {
  const LoginFormInitEvent();
}

class LoginFormEmailChangedEvent extends LoginFormEvent {
  const LoginFormEmailChangedEvent({required this.email});
  final BlocFormItem email;
  @override
  List<Object> get props => [email];
}

class LoginFormPasswordChangedEvent extends LoginFormEvent {
  const LoginFormPasswordChangedEvent({required this.password});
  final BlocFormItem password;
  @override
  List<Object> get props => [password];
}

class LoginFormSubmitEvent extends LoginFormEvent {
  const LoginFormSubmitEvent();
}
