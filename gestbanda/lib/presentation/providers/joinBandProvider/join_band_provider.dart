import 'dart:convert';

import 'package:gestbanda/domain/newmodels/bandModels/join_band_dto.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:gestbanda/utils/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/config.dart';
import '../../../domain/newmodels/bandModels/band_dto.dart';
import '../errorProvider/error_provider.dart';
import '../sharedPreferencesProvider/shared_preferences_provider.dart';
import 'package:http/http.dart' as http;

part 'join_band_provider.g.dart';

/// Provider class for managing the joining of a band by code.
/// Uses Riverpod for state management, handling the join process and validation,
/// including user retrieval and error handling.
@riverpod
class JoinBandProvider extends _$JoinBandProvider {
  String api = "http://192.168.1.50:3000/api";

  /// State to indicate if a request is currently loading
  bool isLoading = false;

  /// Builds an initial JoinBandDTO object with default values.
  @override
  JoinBandDTO build() => JoinBandDTO(
        code: "",
        user: UserDTO(
          id: '',
          name: '',
          email: '',
          phone: '',
          token: '',
        ),
      );

  /// Updates the code in the state if it is different from the current one.
  void changeCode(String code) {
    if (state.code != code) {
      state = state.copyWith(code: code);
    }
  }

  /// Validates the input code format.
  /// Returns null if the code is valid; otherwise, returns an error message.
  String? validateCode(String? val) {
    if (val != null && val.isValidCode) {
      return null;
    }
    return "Debes introducir un código válido";
  }

  /// Retrieves the current user from SharedPreferences and updates the state.
  /// If the user is not found, an error is set in the error provider.
  Future<void> getUser() async {
    String? userJSON = await ref
        .read(sharedPreferencesProviderProvider.notifier)
        .getString(key: 'user');

    if (userJSON != null) {
      state = state.copyWith(user: UserDTO.fromJson(jsonDecode(userJSON)));
    } else {
      ref
          .read(errorProviderProvider.notifier)
          .setError("No se ha encontrado la sesión del usuario.");
    }
  }

  /// Attempts to join a band using the provided code in the state.
  /// Sends a POST request to the API with the current state data.
  /// If successful, it saves the band data and navigates to the director's home screen.
  /// If an error occurs, it sets an appropriate error message in the error provider.
  Future<void> joinBandByCode() async {
    if (isLoading) return;

    // Start loading
    isLoading = true;

    await getUser();
    try {
      final response = await http.post(
        Uri.parse("$api/codes/joinBandByCode"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': state.user.token,
        },
        body: jsonEncode(state),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        final BandDTO band = BandDTO.fromJson(jsonResponse);

        await ref
            .read(sharedPreferencesProviderProvider.notifier)
            .saveString(key: "band", value: json.encode(band.toJson()));
        ref.read(appRouterProvider.notifier).changeRouter(directorRouter);
        final router = await ref.read(appRouterProvider.future);
        router.push("/");
      } else {
        final data = json.decode(response.body);
        ref
            .read(errorProviderProvider.notifier)
            .setError(data["message"].toString());
      }
    } catch (e) {
      ref.read(errorProviderProvider.notifier).setError(
          "Ha ocurrido un error en la aplicacion. Intentalo más tarde.");
    } finally {
      isLoading = false;
    }
  }
}
