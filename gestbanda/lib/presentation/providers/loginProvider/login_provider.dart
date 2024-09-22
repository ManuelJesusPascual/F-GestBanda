import 'dart:convert';

import 'package:gestbanda/domain/newmodels/userModels/login_user_dto.dart';
import 'package:gestbanda/utils/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

import '../../../config/config.dart';
import '../../../domain/newmodels/userModels/user_dto.dart';
import '../errorProvider/error_provider.dart';
import '../sharedPreferencesProvider/shared_preferences_provider.dart';

part 'login_provider.g.dart';

@riverpod
class LoginProvider extends _$LoginProvider {
  String api = "http://192.168.1.50:3000/api";

  @override
  LoginUserDTO build() => LoginUserDTO(email: "", password: "");

  /// Method to change the value of the email variable.
  void changeEmail(String email) {
    if (state.email != email) {
      state = state.copyWith(email: email);
    }
  }

  /// Method to change the value of the password variable.
  void changePassword(String password) {
    if (state.password != password) {
      state = state.copyWith(password: password);
    }
  }

  /// Method that checks if the email is valid.
  String? validateEmail(String? val) {
    if (val != null && val.isValidEmail) {
      return null;
    }
    return "Debes introducir un email válido";
  }

  /// Method that makes a request to the API to log in a user. It collects the token from the response and stores it in SharedPreferences. After that, it changes the router.
  Future<void> login() async {
    try {
      final response = await http.post(Uri.parse("$api/users/login"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(state));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Extracts the token from the headers
        final token = response.headers['authorization'] ?? '';

        final UserDTO user =
            UserDTO.fromJson(jsonResponse).copyWith(token: token);

        await ref
            .read(sharedPreferencesProviderProvider.notifier)
            .saveString(key: "user", value: json.encode(user.toJson()));
        ref.read(appRouterProvider.notifier).changeRouter(authenticatedRouter);
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
    }
  }
}
