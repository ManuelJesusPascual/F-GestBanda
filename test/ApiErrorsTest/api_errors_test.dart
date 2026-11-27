import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gestbanda/utils/api_errors.dart';
import 'package:http/http.dart' as http;

http.Response errorResponse(int status, int code, String message) =>
    http.Response(
      jsonEncode({
        'timeMark': '2026-11-27T19:40:11.714+00:00',
        'message': message,
        'code': code,
      }),
      status,
    );

void main() {
  group('apiErrorMessage', () {
    test('401 with code 14 means the session expired', () {
      final response = errorResponse(401, 14, 'Unauthorized');
      expect(apiErrorMessage(response), sessionExpiredMessage);
      expect(isSessionExpired(response), isTrue);
    });

    test('401 on login shows the API message, not an expired session', () {
      final response = errorResponse(401, 14, 'Credenciales incorrectas');
      expect(apiErrorMessage(response, authenticated: false),
          'Credenciales incorrectas');
    });

    test('403 with code 12 shows the permissions message', () {
      expect(apiErrorMessage(errorResponse(403, 12, 'FORBIDDEN')),
          forbiddenMessage);
    });

    test('500 hides the server message', () {
      expect(
          apiErrorMessage(errorResponse(500, 1, 'Error interno del servidor')),
          serverErrorMessage);
    });

    test('other errors show the API message', () {
      expect(apiErrorMessage(errorResponse(404, 13, 'La voz no existe')),
          'La voz no existe');
      expect(apiErrorMessage(errorResponse(400, 4, 'UUID no válido')),
          'UUID no válido');
    });

    test('a body that is not JSON falls back to a generic message', () {
      expect(apiErrorMessage(http.Response('', 404)), genericErrorMessage);
      expect(isSessionExpired(http.Response('', 403)), isFalse);
    });
  });
}
