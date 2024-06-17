import 'package:equatable/equatable.dart';
import 'package:gestbanda/models/BlocFormItem.dart';

abstract class LoginUserFormEvent extends Equatable {
  const LoginUserFormEvent();

  @override
  List<Object> get props => [];
}

class LoginUserFormInitEvent extends LoginUserFormEvent {
  const LoginUserFormInitEvent();
}

class LoginUserFormEmailChangedEvent extends LoginUserFormEvent {
  const LoginUserFormEmailChangedEvent({required this.email});
  final BlocFormItem email;
  @override
  List<Object> get props => [email];
}

class LoginUserFormPasswordChangedEvent extends LoginUserFormEvent {
  const LoginUserFormPasswordChangedEvent({required this.password});
  final BlocFormItem password;
  @override
  List<Object> get props => [password];
}

class LoginUserFormSubmitEvent extends LoginUserFormEvent {
  const LoginUserFormSubmitEvent();
}
