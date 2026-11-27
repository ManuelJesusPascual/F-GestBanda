import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:image_picker/image_picker.dart';

class RegisterBandDTO {
  String name;
  UserDTO user;
  XFile img;

  RegisterBandDTO({required this.name, required this.img, required this.user});

  RegisterBandDTO copyWith({
    String? name,
    UserDTO? user,
    XFile? img,
  }) {
    return RegisterBandDTO(
      name: name ?? this.name,
      user: user ?? this.user,
      img: img ?? this.img,
    );
  }

  // The API takes the creator from the JWT, so `user` stays local (for the token).
  Map<String, dynamic> toJson() => {'name': name};

  factory RegisterBandDTO.fromJson(Map<String, dynamic> json, XFile img) {
    return RegisterBandDTO(
      name: json['name'],
      user: json['user'],
      img: img,
    );
  }
}
