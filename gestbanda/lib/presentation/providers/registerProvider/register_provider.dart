import 'dart:convert';

import 'package:gestbanda/config/router/routes_config.dart';
import 'package:gestbanda/domain/newmodels/userModels/register_user_dto.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:gestbanda/presentation/providers/errorProvider/error_provider.dart';
import 'package:gestbanda/presentation/providers/sharedPreferencesProvider/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

import "../../../../utils/extensions.dart";

part 'register_provider.g.dart';

/// Provider que usaremos para la lógica de registro de un usuario.
@riverpod
class RegisterProvider extends _$RegisterProvider {
  String api = "http://192.168.1.50:3000/api";

  @override
  RegisterUserDTO build() => RegisterUserDTO(
      name: "", email: "", phone: "", password: "", confirmPassword: "");

  /// Método para cambiar el valor de la variable name.
  void changeName(String name) {
    if (state.name != name) {
      state = state.copyWith(name: name);
    }
  }

  /// Método para cambiar el valor de la variable email.
  void changeEmail(String email) {
    if (state.email != email) {
      state = state.copyWith(email: email);
    }
  }

  /// Método para cambiar el valor de la variable phone.
  void changePhone(String phone) {
    if (state.phone != phone) {
      state = state.copyWith(phone: phone);
    }
  }

  /// Método para cambiar el valor de la variable password.
  void changePassword(String password) {
    if (state.password != password) {
      state = state.copyWith(password: password);
    }
  }

  /// Método para cambiar el valor de la variable confirmPassword.
  void changeConfirmPassword(String confirmPassword) {
    if (state.confirmPassword != confirmPassword) {
      state = state.copyWith(confirmPassword: confirmPassword);
    }
  }

  /// Método que comprueba si la contraseñas son iguales.
  bool isValidConfirmPassword() {
    return state.confirmPassword == state.password;
  }

  /// Método que comprueba si el nombre es válido.
  String? validateName(String? val) {
    if (val != null && val.isValidName) {
      return null;
    }
    return "Debes introducir un nombre válido";
  }

  /// Método que comprueba si el email es válido.
  String? validateEmail(String? val) {
    if (val != null && val.isValidEmail) {
      return null;
    }
    return "Debes introducir un email válido";
  }

  /// Método que comprueba si el teléfono es válido.
  String? validatePhone(String? val) {
    if (val != null && val.isValidPhone) {
      return null;
    }
    return "Debes introducir un teléfono válido";
  }

  /// Método que comprueba si la contraseña es válida.
  String? validatePassword(String? val) {
    if (val != null && !val.isValidPasswordLength) {
      return "La contraseña debe tener al menos 8 caracteres";
    } else if (val != null && !val.isValidPasswordMayus) {
      return "La contraseña debe tener mayúsculas";
    } else if (val != null && !val.isValidPasswordMinus) {
      return "La contraseña debe tener minusculas";
    } else if (val != null && !val.isValidPasswordNumber) {
      return "La contraseña debe tener al menos un número";
    } else if (val != null && !val.isValidPasswordSpecialCharacters) {
      return "La contraseña debe tener caracteres especiales";
    } else if (val != null && val.isValidPassword) {
      return null;
    }
    return "Debes introducir una contraseña válida";
  }

  /// Método que comprueba si las contraseñas son iguales.
  String? validateConfirmPassword(String? val) {
    if (val != null && isValidConfirmPassword()) {
      return null;
    }
    return "Las contraseñas no coinciden";
  }

  /// Método que realiza una petición a la API para registrar un usuario. Recoge el token de la respuesta y lo almacena en SharedPreferences. Tras eso cambia el router.
  Future<void> register() async {
    try {
      final response = await http.post(Uri.parse("$api/users/registerUser"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(state));

      if (response.statusCode == 201) {
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
