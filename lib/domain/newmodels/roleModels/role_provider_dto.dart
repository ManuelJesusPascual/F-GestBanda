import 'package:gestbanda/domain/newmodels/bandModels/band_dto.dart';

import '../userModels/user_dto.dart';
import 'role_dto.dart';

class RoleProviderDTO {
  List<RoleDTO> roles;
  bool isLoading;
  UserDTO user;
  BandDTO band;

  RoleProviderDTO({
    required this.roles,
    required this.isLoading,
    required this.user,
    required this.band,
  });

  RoleProviderDTO copyWith({
    List<RoleDTO>? roles,
    bool? isLoading,
    UserDTO? user,
    BandDTO? band,
  }) {
    return RoleProviderDTO(
      roles: roles ?? this.roles,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      band: band ?? this.band,
    );
  }

  Map<String, dynamic> toJson() => {
        "roles": roles,
        "isLoading": isLoading,
        "user": user,
        "band": band,
      };

  factory RoleProviderDTO.fromJson(Map<String, dynamic> json) {
    return RoleProviderDTO(
      roles: RoleDTO.listFromJson(json['roles']),
      isLoading: json['isLoading'],
      user: UserDTO.fromJson(json['user']),
      band: BandDTO.fromJson(json['band']),
    );
  }

  static List<RoleProviderDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => RoleProviderDTO.fromJson(json)).toList();
  }
}
