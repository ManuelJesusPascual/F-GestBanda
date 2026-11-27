import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/router/routes_config.dart';
import '../presentation/providers/errorProvider/error_provider.dart';
import '../presentation/providers/sharedPreferencesProvider/shared_preferences_provider.dart';

/// `code` values of the API error body (ErrorCodes in B-GestBanda).
const int forbiddenErrorCode = 12;
const int unauthorizedErrorCode = 14;

const String sessionExpiredMessage =
    "Tu sesión ha caducado. Vuelve a iniciar sesión.";
const String forbiddenMessage =
    "No tienes permisos para realizar esta acción en esta banda.";
const String serverErrorMessage =
    "Ha ocurrido un error en el servidor. Inténtalo más tarde.";
const String genericErrorMessage =
    "Ha ocurrido un error en la aplicación. Inténtalo más tarde.";

/// Picks the message to show for an error response of the API.
///
/// Set [authenticated] to false for login and registration, where a 401
/// means wrong credentials rather than an expired session.
String apiErrorMessage(http.Response response, {bool authenticated = true}) {
  final body = _decodeBody(response.body);
  final code = body?['code'];
  if (authenticated &&
      (response.statusCode == 401 || code == unauthorizedErrorCode)) {
    return sessionExpiredMessage;
  }
  if (response.statusCode == 403 || code == forbiddenErrorCode) {
    return forbiddenMessage;
  }
  if (response.statusCode >= 500) return serverErrorMessage;
  final message = body?['message'];
  return message is String && message.isNotEmpty
      ? message
      : genericErrorMessage;
}

bool isSessionExpired(http.Response response) =>
    response.statusCode == 401 ||
    _decodeBody(response.body)?['code'] == unauthorizedErrorCode;

/// Shows the error of [response] and, on 401, closes the session and goes
/// back to the login screens.
///
/// Pass `expireSession: false` where the router is still being built.
Future<void> handleApiError(
  Ref ref,
  http.Response response, {
  bool authenticated = true,
  bool expireSession = true,
}) async {
  ref
      .read(errorProviderProvider.notifier)
      .setError(apiErrorMessage(response, authenticated: authenticated));
  if (authenticated && expireSession && isSessionExpired(response)) {
    final storage = ref.read(sharedPreferencesProviderProvider.notifier);
    await storage.removeString(key: "user");
    await storage.removeString(key: "band");
    ref.read(appRouterProvider.notifier).changeRouter(unauthenticatedRouter);
  }
}

Map<String, dynamic>? _decodeBody(String body) {
  try {
    final decoded = json.decode(body);
    return decoded is Map<String, dynamic> ? decoded : null;
  } catch (_) {
    return null;
  }
}
