import 'package:gestbanda/models/Costume.dart';
import 'package:gestbanda/models/Instrument.dart';

class User {
  final String name;
  final String role;
  final String voz;
  List<Instrument> instrumentList;
  List<Costume> costumeList;
  String? img;

  User({
    required this.name,
    required this.role,
    required this.voz,
    required this.instrumentList,
    required this.costumeList,
    this.img,
  });

  User copyWith({
    String? name,
    String? role,
    String? voz,
    List<Instrument>? instrumentList,
    List<Costume>? costumeList,
    String? img,
  }) {
    return User(
      name: name ?? this.name,
      role: role ?? this.role,
      voz: voz ?? this.voz,
      instrumentList: instrumentList ?? this.instrumentList,
      costumeList: costumeList ?? this.costumeList,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'role': role,
        'voz': voz,
        'instrumentList': instrumentList.map((e) => e.toJson()).toList(),
        'costumeList': costumeList.map((e) => e.toJson()).toList(),
        'img': img,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
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
