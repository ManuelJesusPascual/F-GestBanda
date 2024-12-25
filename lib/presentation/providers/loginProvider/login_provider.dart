import 'dart:convert';

import 'package:gestbanda/domain/newmodels/userBandsModels/user_bands_dto.dart';
import 'package:gestbanda/domain/newmodels/userModels/login_user_dto.dart';
import 'package:gestbanda/utils/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

import '../../../config/config.dart';
import '../../../domain/newmodels/bandModels/band_dto.dart';
import '../../../domain/newmodels/userModels/user_dto.dart';
import '../../../utils/properties_manager.dart';
import '../errorProvider/error_provider.dart';
import '../sharedPreferencesProvider/shared_preferences_provider.dart';

part 'login_provider.g.dart';

/// Provider for handling user login operations and managing login state
/// such as email and password, as well as API interactions for user login.
@riverpod
class LoginProvider extends _$LoginProvider {
  /// State to indicate if a request is currently loading
  bool isLoading = false;

  // Initializes the provider with a default LoginUserDTO object.
  @override
  LoginUserDTO build() => LoginUserDTO(email: "", password: "");

  /// Updates the email in the current login state.
  /// Only updates if the new email is different from the current one.
  void changeEmail(String email) {
    if (state.email != email) {
      state = state.copyWith(email: email);
    }
  }

  /// Updates the password in the current login state.
  /// Only updates if the new password is different from the current one.
  void changePassword(String password) {
    if (state.password != password) {
      state = state.copyWith(password: password);
    }
  }

  /// Validates the email format using an extension method.
  /// Returns an error message if invalid, otherwise returns null.
  String? validateEmail(String? val) {
    if (val != null && val.isValidEmail) {
      return null;
    }
    return "Debes introducir un email válido";
  }

  /// Handles the login process by sending the login data to the API.
  /// If successful, it saves the user and token in SharedPreferences and
  /// fetches the bands associated with the user.
  Future<void> login() async {
    final api = await loadFromProperties("api_url");

    if (isLoading) return;

    // Start loading
    isLoading = true;
    try {
      final response = await http.post(
        Uri.parse("$api/users/login"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(state),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Extracts the token from the headers
        final token = response.headers['authorization'] ?? '';

        final UserDTO user =
            UserDTO.fromJson(jsonResponse).copyWith(token: token);
        await getBands(user.id, token);
        await ref
            .read(sharedPreferencesProviderProvider.notifier)
            .saveString(key: "user", value: json.encode(user.toJson()));
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

  /// Fetches the list of bands associated with the user.
  /// If the user has bands, the first band is saved in SharedPreferences,
  /// and the router navigates to the director's main page.
  /// Otherwise, it navigates to the authenticated user's main page.
  Future<void> getBands(String id, String token) async {
    final api = await loadFromProperties("api_url");

    try {
      final response = await http.get(
        Uri.parse("$api/userBands/getUserBands?id=$id"),
        headers: <String, String>{
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        final List<UserBandsDTO> userBands =
            UserBandsDTO.listFromJson(jsonResponse);

        if (userBands.isNotEmpty) {
          final BandDTO band = userBands.first
              .band; // It is not yet implemented for the user to be in multiple bands on the front end, so we are taking the first one.
          await ref
              .read(sharedPreferencesProviderProvider.notifier)
              .saveString(key: "band", value: json.encode(band));
          ref.read(appRouterProvider.notifier).changeRouter(directorRouter);
          final router = await ref.read(appRouterProvider.future);
          router.push("/");
        } else {
          ref
              .read(appRouterProvider.notifier)
              .changeRouter(authenticatedRouter);
          final router = await ref.read(appRouterProvider.future);
          router.push("/");
        }
      } else {
        final data = json.decode(response.body);
        ref
            .read(errorProviderProvider.notifier)
            .setError(data["message"].toString());
      }
    } catch (e) {
      ref.read(errorProviderProvider.notifier).setError(
          "Ha ocurrido un error al obtener tu banda. Intentalo más tarde.");
    }
  }
}
