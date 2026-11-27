import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';

import '../codesModels/codes.dart';

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

  // The API takes the user from the JWT, so `user` stays local (for the token).
  Map<String, dynamic> toJson() => {'code': code};

  factory JoinBandDTO.fromJson(Map<String, dynamic> json) {
    return JoinBandDTO(
      code: invitationCodeFromJson(json['code']),
      user: json['user'],
    );
  }
}
