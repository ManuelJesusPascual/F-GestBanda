import 'package:gestbanda/domain/newmodels/bandModels/band_dto.dart';
import 'package:gestbanda/domain/newmodels/userBandsModels/user_bands_dto.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';

class UserBandProviderDTO {
  List<UserBandsDTO> userBands;
  UserDTO user;
  UserDTO userModify;

  BandDTO band;
  bool isLoading = false;

  UserBandProviderDTO(
      {required this.userBands,
      required this.user,
      required this.userModify,
      required this.band,
      this.isLoading = false});

  UserBandProviderDTO copyWith(
      {List<UserBandsDTO>? userBands,
      UserDTO? user,
      UserDTO? userModify,
      BandDTO? band,
      bool? isLoading}) {
    return UserBandProviderDTO(
        userBands: userBands ?? this.userBands,
        user: user ?? this.user,
        userModify: userModify ?? this.userModify,
        band: band ?? this.band,
        isLoading: isLoading ?? this.isLoading);
  }

  Map<String, dynamic> toJson() => {
        'userBands': userBands.map((e) => e.toJson()).toList(),
        'user': user.toJson(),
        'band': band.toJson(),
      };

  static UserBandProviderDTO fromJson(Map<String, dynamic> json) {
    return UserBandProviderDTO(
      userBands: UserBandsDTO.listFromJson(json['userBands']),
      user: UserDTO.fromJson(json['user']),
      userModify: UserDTO.fromJson(json['userModify']),
      band: BandDTO.fromJson(json['band']),
    );
  }

  static List<UserBandProviderDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => UserBandProviderDTO.fromJson(json)).toList();
  }
}
