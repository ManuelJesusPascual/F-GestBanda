class ModifyUserBandsDTO {
  String userId;
  String voiceId;
  String roleId;
  String bandId;

  ModifyUserBandsDTO({
    required this.userId,
    required this.voiceId,
    required this.roleId,
    required this.bandId,
  });

  ModifyUserBandsDTO copyWith(
      {required userID, required vozID, required roleID, required bandID}) {
    return ModifyUserBandsDTO(
        userId: userID ?? userId,
        voiceId: vozID ?? voiceId,
        roleId: roleID ?? roleId,
        bandId: bandID ?? bandId);
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'voice_id': voiceId,
        'role_id': roleId,
        'band_id': bandId,
      };

  static ModifyUserBandsDTO fromJson(Map<String, dynamic> json) {
    return ModifyUserBandsDTO(
      userId: json['user_id'],
      voiceId: json['voice_id'],
      roleId: json['role_id'],
      bandId: json['band_id'],
    );
  }

  static List<ModifyUserBandsDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ModifyUserBandsDTO.fromJson(json)).toList();
  }
}
