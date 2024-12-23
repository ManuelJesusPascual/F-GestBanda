class CreateUpdateCodeDTO {
  String? id;
  String bandID;
  String? voiceID;
  DateTime endDate;

  CreateUpdateCodeDTO({
    this.id,
    required this.bandID,
    this.voiceID,
    required this.endDate,
  });

  CreateUpdateCodeDTO copyWith({
    String? id,
    String? bandID,
    String? voiceID,
    DateTime? endDate,
  }) {
    return CreateUpdateCodeDTO(
      id: id ?? this.id,
      bandID: bandID ?? this.bandID,
      voiceID: voiceID ?? this.voiceID,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'band_id': bandID,
        'voice_id': voiceID,
        'end_date': endDate.toIso8601String(),
      };

  factory CreateUpdateCodeDTO.fromJson(Map<String, dynamic> json) {
    return CreateUpdateCodeDTO(
      id: json['id'],
      bandID: json['band_id'],
      voiceID: json['voice_id'],
      endDate: DateTime.parse(json['end_date']),
    );
  }
}
