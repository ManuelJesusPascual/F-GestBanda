import 'package:gestbanda/domain/newmodels/bandModels/band_dto.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';

import 'voice_dto.dart';

class VoiceProviderDTO {
  List<VoiceDTO> bandVoices;
  List<VoiceDTO> voicesBandNotHave;
  UserDTO user;
  BandDTO band;
  bool isLoading = false;

  VoiceProviderDTO({
    required this.bandVoices,
    required this.user,
    required this.band,
    required this.voicesBandNotHave,
    this.isLoading = false,
  });

  VoiceProviderDTO copyWith({
    List<VoiceDTO>? bandVoices,
    List<VoiceDTO>? voicesBandNotHave,
    UserDTO? user,
    BandDTO? band,
    bool? isLoading,
  }) {
    return VoiceProviderDTO(
      bandVoices: bandVoices ?? this.bandVoices,
      voicesBandNotHave: voicesBandNotHave ?? this.voicesBandNotHave,
      user: user ?? this.user,
      band: band ?? this.band,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toJson() => {
        'bandVoices': bandVoices,
        'voicesBandNotHave': voicesBandNotHave,
        'user': user,
        'band': band,
      };

  factory VoiceProviderDTO.fromJson(Map<String, dynamic> json) {
    return VoiceProviderDTO(
      bandVoices: json['bandVoices'],
      voicesBandNotHave: json['voicesBandNotHave'],
      user: json['user'],
      band: json['band'],
    );
  }
}
