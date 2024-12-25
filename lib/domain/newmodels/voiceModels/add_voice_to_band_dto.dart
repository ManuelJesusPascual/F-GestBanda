class AddVoiceToBandDTO {
  String band_uuid;
  String voice_name;

  AddVoiceToBandDTO({
    required this.band_uuid,
    required this.voice_name,
  });

  AddVoiceToBandDTO copyWith({
    String? band_uuid,
    String? voice_name,
  }) {
    return AddVoiceToBandDTO(
      band_uuid: band_uuid ?? this.band_uuid,
      voice_name: voice_name ?? this.voice_name,
    );
  }

  Map<String, dynamic> toJson() => {
        'band_uuid': band_uuid,
        'voice_name': voice_name,
      };

  factory AddVoiceToBandDTO.fromJson(Map<String, dynamic> json) {
    return AddVoiceToBandDTO(
      band_uuid: json['band_uuid'],
      voice_name: json['voice_name'],
    );
  }
}
