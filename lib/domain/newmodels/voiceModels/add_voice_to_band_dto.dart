class AddVoiceToBandDTO {
  String bandUuid;
  String voiceName;

  AddVoiceToBandDTO({
    required this.bandUuid,
    required this.voiceName,
  });

  AddVoiceToBandDTO copyWith({
    String? bandUuid,
    String? voiceName,
  }) {
    return AddVoiceToBandDTO(
      bandUuid: bandUuid ?? this.bandUuid,
      voiceName: voiceName ?? this.voiceName,
    );
  }

  Map<String, dynamic> toJson() => {
        'band_uuid': bandUuid,
        'voice_name': voiceName,
      };

  factory AddVoiceToBandDTO.fromJson(Map<String, dynamic> json) {
    return AddVoiceToBandDTO(
      bandUuid: json['band_uuid'],
      voiceName: json['voice_name'],
    );
  }
}
