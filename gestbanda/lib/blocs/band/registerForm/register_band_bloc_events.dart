import 'package:equatable/equatable.dart';
import 'package:gestbanda/models/bloc_form_item.dart';

abstract class RegisterBandFormEvents extends Equatable {
  const RegisterBandFormEvents();
  @override
  List<Object?> get props => [];
}

class RegisterBandFormInitEvent extends RegisterBandFormEvents {
  const RegisterBandFormInitEvent();
}

class RegisterBandFormNameChangedEvent extends RegisterBandFormEvents {
  const RegisterBandFormNameChangedEvent({required this.name});
  final BlocFormItem name;
  @override
  List<Object?> get props => [name];
}

class RegisterBandFormImgChangedEvent extends RegisterBandFormEvents {
  const RegisterBandFormImgChangedEvent();
  @override
  List<Object?> get props => [];
}

class RegisterBandFromSubmitEvent extends RegisterBandFormEvents {
  const RegisterBandFromSubmitEvent();
}
