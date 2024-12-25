import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';

class JoinBandDTO {
  String code;
  UserDTO user;

  JoinBandDTO({required this.code, required this.user});

  JoinBandDTO copyWith({
    String? code,
    UserDTO? user,
  }) {
    return JoinBandDTO(
      code: code ?? this.code,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toJson() => {'code': code, 'user': user};

  factory JoinBandDTO.fromJson(Map<String, dynamic> json) {
    return JoinBandDTO(
      code: json['code'],
      user: json['user'],
    );
  }
}
