import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/config/router/routes_config.dart';
import 'package:gestbanda/domain/newmodels/userModels/register_user_dto.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:gestbanda/presentation/providers/errorProvider/error_provider.dart';
import 'package:gestbanda/presentation/providers/sharedPreferencesProvider/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

import "../../../../utils/extensions.dart";

part 'register_provider.g.dart';

/// Provider that we will use for the user registration logic.
@riverpod
class RegisterProvider extends _$RegisterProvider {
  String api = "http://192.168.1.50:3000/api";

  /// State to indicate if a request is currently loading
  bool isLoading = false;

  @override
  RegisterUserDTO build() => RegisterUserDTO(
      name: "", email: "", phone: "", password: "", confirmPassword: "");

  /// Method to change the value of the name variable.
  void changeName(String name) {
    if (state.name != name) {
      state = state.copyWith(name: name);
    }
  }

  /// Method to change the value of the email variable.
  void changeEmail(String email) {
    if (state.email != email) {
      state = state.copyWith(email: email);
    }
  }

  /// Method to change the value of the phone variable.
  void changePhone(String phone) {
    if (state.phone != phone) {
      state = state.copyWith(phone: phone);
    }
  }

  /// Method to change the value of the password variable.
  void changePassword(String password) {
    if (state.password != password) {
      state = state.copyWith(password: password);
    }
  }

  /// Method to change the value of the confirmPassword variable.
  void changeConfirmPassword(String confirmPassword) {
    if (state.confirmPassword != confirmPassword) {
      state = state.copyWith(confirmPassword: confirmPassword);
    }
  }

  /// Method that checks if the passwords are the same.
  bool isValidConfirmPassword() {
    return state.confirmPassword == state.password;
  }

  /// Method that checks if the name is valid.
  String? validateName(String? val) {
    if (val != null && val.isValidName) {
      if (val.length < 60) {
        return null;
      } else {
        return "El nombre es demasiado largo";
      }
    }
    return "Debes introducir un nombre válido";
  }

  /// Method that checks if the email is valid.
  String? validateEmail(String? val) {
    if (val != null && val.isValidEmail) {
      return null;
    }
    return "Debes introducir un email válido";
  }

  /// Method that checks if the phone number is valid.
  String? validatePhone(String? val) {
    if (val != null && val.isValidPhone) {
      return null;
    }
    return "Debes introducir un teléfono válido";
  }

  /// Method that checks if the password is valid.
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

  /// Method that checks if the passwords match.
  String? validateConfirmPassword(String? val) {
    if (val != null && isValidConfirmPassword()) {
      return null;
    }
    return "Las contraseñas no coinciden";
  }

  /// Method that makes a request to the API to register a user. It collects the token from the response and stores it in SharedPreferences. After that, it changes the router.
  Future<void> register() async {
    isLoading = true;
    try {
      final response = await http.post(Uri.parse("$api/users/registerUser"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(state));

      if (response.statusCode == 201) {
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
    } finally {
      isLoading = false;
    }
  }
}

class PasswordVisibilityNotifier extends StateNotifier<bool> {
  PasswordVisibilityNotifier() : super(true); // true = password hidden

  Icon get icon => state
      ? const Icon(Icons.remove_red_eye)
      : const Icon(Icons.visibility_off);

  void toggle() {
    state = !state;
  }
}

final passwordVisibilityProvider =
    StateNotifierProvider<PasswordVisibilityNotifier, bool>((ref) {
  return PasswordVisibilityNotifier();
});
