import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/config/api_config.dart';
import 'package:gestbanda/domain/newmodels/bandModels/band_dto.dart';
import 'package:gestbanda/domain/newmodels/roleModels/band_permissions.dart';
import 'package:gestbanda/domain/newmodels/userBandsModels/user_bands_dto.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:gestbanda/presentation/providers/sharedPreferencesProvider/shared_preferences_provider.dart';
import 'package:gestbanda/utils/api_errors.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'band_permissions_provider.g.dart';

/// Permissions of the logged-in user in the stored band, from the `role` and
/// `voice` that getUserBands returns for that band.
///
/// Kept alive for the session; AppRouter.changeRouter invalidates it on
/// login, logout and band changes.
@Riverpod(keepAlive: true)
Future<BandPermissions> bandPermissions(Ref ref) async {
  final storage = ref.read(sharedPreferencesProviderProvider.notifier);
  final userJson = await storage.getString(key: 'user');
  final bandJson = await storage.getString(key: 'band');
  if (userJson == null || bandJson == null) return BandPermissions.none;

  final user = UserDTO.fromJson(json.decode(userJson));
  final band = BandDTO.fromJson(json.decode(bandJson));

  try {
    final response = await http.get(
      Uri.parse("$apiUrl/userBands/getUserBands?id=${user.id}"),
      headers: <String, String>{
        'Authorization': user.token,
      },
    );
    if (response.statusCode != 200) {
      await handleApiError(ref, response);
      return BandPermissions.none;
    }
    final membership = UserBandsDTO.listFromJson(jsonDecode(response.body))
        .where((userBand) => userBand.band.id == band.id)
        .firstOrNull;
    return membership == null
        ? BandPermissions.none
        : BandPermissions(
            role: membership.role.name, voiceId: membership.voice.id);
  } catch (e) {
    return BandPermissions.none;
  }
}
