import 'package:gestbanda/domain/models/costume.dart';
import 'package:gestbanda/domain/models/instrument.dart';

class User {
  String name;
  String email;
  String phone;
  String role;
  String voz;
  List<Instrument> instrumentList;
  List<Costume> costumeList;
  String? img;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.voz,
    required this.instrumentList,
    required this.costumeList,
    this.img,
  });

  User copyWith({
    String? name,
    String? email,
    String? phone,
    String? role,
    String? voz,
    List<Instrument>? instrumentList,
    List<Costume>? costumeList,
    String? img,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      voz: voz ?? this.voz,
      instrumentList: instrumentList ?? this.instrumentList,
      costumeList: costumeList ?? this.costumeList,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        'voz': voz,
        'instrumentList': instrumentList.map((e) => e.toJson()).toList(),
        'costumeList': costumeList.map((e) => e.toJson()).toList(),
        'img': img,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      voz: json['voz'],
      instrumentList: (json['instrumentList'] as List<dynamic>)
          .map((e) => Instrument.fromJson(e))
          .toList(),
      costumeList: (json['costumeList'] as List<dynamic>)
          .map((e) => Costume.fromJson(e))
          .toList(),
      img: json['img'],
    );
  }
}
