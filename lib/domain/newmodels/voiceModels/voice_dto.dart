class VoiceDTO {
  String id;
  String name;

  VoiceDTO({
    required this.id,
    required this.name,
  });

  VoiceDTO copyWith({
    String? id,
    String? name,
  }) {
    return VoiceDTO(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  factory VoiceDTO.fromJson(Map<String, dynamic> json) {
    return VoiceDTO(
      id: json['id'],
      name: json['name'],
    );
  }
}
