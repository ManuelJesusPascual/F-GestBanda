import 'package:gestbanda/domain/models/costume.dart';

import '../../models/instrument.dart';
import '../roleModels/role_dto.dart';
import '../voiceModels/voice_dto.dart';

class UserDTO {
  String id;
  String name;
  String email;
  String phone;
  String? img;
  String token;
  RoleDTO? role;
  VoiceDTO? voz;
  List<Instrument>? instrumentList;
  List<Costume>? costumeList;

  UserDTO({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.img,
    required this.token,
    this.role,
    this.voz,
    this.instrumentList,
    this.costumeList,
  });

  UserDTO copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? img,
    String? token,
    RoleDTO? role,
    VoiceDTO? voz,
    List<Instrument>? instrumentList,
    List<Costume>? costumeList,
  }) {
    return UserDTO(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      img: img ?? this.img,
      token: token ?? this.token,
      role: role ?? this.role,
      voz: voz ?? this.voz,
      instrumentList: instrumentList ?? this.instrumentList,
      costumeList: costumeList ?? this.costumeList,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'img': img,
        'token': token,
        'role': role?.toJson(),
        'voice': voz?.toJson(),
        'instrumentList':
            instrumentList?.map((instrument) => instrument.toJson()).toList(),
        'costumeList': costumeList?.map((costume) => costume.toJson()).toList(),
      };

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        img: json['img'],
        token: json['token'] ?? '',
        role: (json['role'] != null) ? RoleDTO.fromJson(json['role']) : null,
        voz: (json['voice'] != null) ? VoiceDTO.fromJson(json['voice']) : null,
        instrumentList: (json['instrumentList'] != null)
            ? Instrument.listFromJson(json['instrumentList'])
            : null,
        costumeList: (json['costumeList'] != null)
            ? Costume.listFromJson(json['costumeList'])
            : null);
  }
}
