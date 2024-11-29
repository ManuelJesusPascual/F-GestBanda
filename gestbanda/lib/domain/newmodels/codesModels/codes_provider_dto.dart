import 'package:gestbanda/domain/newmodels/bandModels/band_dto.dart';
import 'package:gestbanda/domain/newmodels/codesModels/codes.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';

class CodesProviderDTO {
  List<CodesDTO> codes;
  CodesDTO createModifyCode;
  BandDTO band;
  UserDTO user;
  bool isLoading = false;

  CodesProviderDTO({
    required this.codes,
    required this.createModifyCode,
    required this.band,
    required this.user,
    this.isLoading = false,
  });

  CodesProviderDTO copyWith({
    List<CodesDTO>? codes,
    CodesDTO? createModifyCode,
    BandDTO? band,
    UserDTO? user,
    bool? isLoading,
  }) {
    return CodesProviderDTO(
      codes: codes ?? this.codes,
      createModifyCode: createModifyCode ?? this.createModifyCode,
      band: band ?? this.band,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toJson() => {
        'codes': codes.map((e) => e.toJson()).toList(),
        'createModifyCode': createModifyCode.toJson(),
        'band': band.toJson(),
        'user': user.toJson(),
      };

  factory CodesProviderDTO.fromJson(Map<String, dynamic> json) {
    return CodesProviderDTO(
      codes: json['codes'],
      createModifyCode: json['createModifyCode'],
      band: json['band'],
      user: json['user'],
    );
  }
}
