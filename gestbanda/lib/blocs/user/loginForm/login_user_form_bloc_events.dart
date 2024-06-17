import 'package:equatable/equatable.dart';
import 'package:gestbanda/models/BlocFormItem.dart';

abstract class LoginUserFormEvent extends Equatable {
  const LoginUserFormEvent();

  @override
  List<Object> get props => [];
}

class LoginFormInitEvent extends LoginUserFormEvent {
  const LoginFormInitEvent();
}

class LoginFormEmailChangedEvent extends LoginUserFormEvent {
  const LoginFormEmailChangedEvent({required this.email});
  final BlocFormItem email;
  @override
  List<Object> get props => [email];
}

class LoginFormPasswordChangedEvent extends LoginUserFormEvent {
  const LoginFormPasswordChangedEvent({required this.password});
  final BlocFormItem password;
  @override
  List<Object> get props => [password];
}

class LoginFormSubmitEvent extends LoginUserFormEvent {
  const LoginFormSubmitEvent();
}
