import '../bandModels/band_dto.dart';
import '../roleModels/role_dto.dart';
import '../userModels/user_dto.dart';

class UserBandsDTO {
  UserDTO user;
  BandDTO band;
  RoleDTO role;

  UserBandsDTO({
    required this.user,
    required this.band,
    required this.role,
  });

  UserBandsDTO copyWith({
    UserDTO? user,
    BandDTO? band,
    RoleDTO? role,
  }) {
    return UserBandsDTO(
      user: user ?? this.user,
      band: band ?? this.band,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'band': band.toJson(),
        'role': role.toJson(),
      };

  static UserBandsDTO fromJson(Map<String, dynamic> json) {
    return UserBandsDTO(
      user: UserDTO.fromJson(json['user']),
      band: BandDTO.fromJson(json['band']),
      role: RoleDTO.fromJson(json['role']),
    );
  }

  static List<UserBandsDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => UserBandsDTO.fromJson(json)).toList();
  }
}
