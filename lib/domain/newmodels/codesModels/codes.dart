import 'package:gestbanda/domain/newmodels/voiceModels/voice_dto.dart';

class CodesDTO {
  String id;
  String code;
  VoiceDTO voice;
  DateTime endDate;
  DateTime createdDate;

  CodesDTO({
    required this.id,
    required this.code,
    required this.voice,
    required this.endDate,
    required this.createdDate,
  });

  CodesDTO copyWith({
    String? id,
    String? code,
    VoiceDTO? voice,
    DateTime? endDate,
    DateTime? createdDate,
  }) {
    return CodesDTO(
      id: id ?? this.id,
      code: code ?? this.code,
      voice: voice ?? this.voice,
      endDate: endDate ?? this.endDate,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'voice': voice.toJson(),
        'endDate': endDate.toIso8601String(),
        'createdDate': createdDate.toIso8601String(),
      };

  factory CodesDTO.fromJson(Map<String, dynamic> json) {
    return CodesDTO(
      id: json['id'],
      code: invitationCodeFromJson(json['code']),
      voice: VoiceDTO.fromJson(json['voice']),
      endDate: DateTime.parse(json['endDate']),
      createdDate: DateTime.parse(json['createdDate']),
    );
  }
}

/// Invitation codes are text: six digits with leading zeros (e.g. 004821).
/// Pads a code that arrives as a number so the zeros are not lost.
String invitationCodeFromJson(Object? value) => value is num
    ? value.toInt().toString().padLeft(6, '0')
    : (value as String? ?? '');
