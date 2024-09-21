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

  /// Método para cambiar el valor de la variable email.
  void changeEmail(String email) {
    if (state.email != email) {
      state = state.copyWith(email: email);
    }
  }

  /// Método para cambiar el valor de la variable password.
  void changePassword(String password) {
    if (state.password != password) {
      state = state.copyWith(password: password);
    }
  }

  /// Método que comprueba si el email es válido.
  String? validateEmail(String? val) {
    if (val != null && val.isValidEmail) {
      return null;
    }
    return "Debes introducir un email válido";
  }

  /// Método que realiza una petición a la API para registrar un usuario. Recoge el token de la respuesta y lo almacena en SharedPreferences. Tras eso cambia el router.
  Future<void> login() async {
    try {
      final response = await http.post(Uri.parse("$api/users/login"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(state));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Extrae el token de los headers
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
