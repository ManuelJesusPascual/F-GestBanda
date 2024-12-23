class ModifyUserBandsDTO {
  String user_id;
  String voz_id;
  String role_id;
  String band_id;

  ModifyUserBandsDTO({
    required this.user_id,
    required this.voz_id,
    required this.role_id,
    required this.band_id,
  });

  ModifyUserBandsDTO copyWith(
      {required userID, required vozID, required roleID, required bandID}) {
    return ModifyUserBandsDTO(
        user_id: userID ?? this.user_id,
        voz_id: vozID ?? this.voz_id,
        role_id: roleID ?? this.role_id,
        band_id: bandID ?? this.band_id);
  }

  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'voice_id': voz_id,
        'role_id': role_id,
        'band_id': band_id,
      };

  static ModifyUserBandsDTO fromJson(Map<String, dynamic> json) {
    return ModifyUserBandsDTO(
      user_id: json['user_id'],
      voz_id: json['voice_id'],
      role_id: json['role_id'],
      band_id: json['band_id'],
    );
  }

  static List<ModifyUserBandsDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ModifyUserBandsDTO.fromJson(json)).toList();
  }
}
