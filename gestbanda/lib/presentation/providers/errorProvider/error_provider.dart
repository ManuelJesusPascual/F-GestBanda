import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_provider.g.dart';

/// Provider que usaremos para mostrar errores por pantalla.
@riverpod
class ErrorProvider extends _$ErrorProvider {
  @override
  String build() {
    return "";
  }

  /// Método que establece el mensaje de error.
  void setError(String error) {
    state = error;
  }
}
