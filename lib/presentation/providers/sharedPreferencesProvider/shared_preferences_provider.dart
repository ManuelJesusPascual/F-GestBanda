import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gestbanda/presentation/providers/errorProvider/error_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shared_preferences_provider.g.dart';

/// Provider que usaremos para manejar el almacenamiento local de la sesión
/// (usuario con su token y banda actual).
///
/// Mantiene el nombre original, pero guarda los datos con
/// flutter_secure_storage (Keychain en iOS, cifrado con Android Keystore)
/// en lugar de SharedPreferences, que los dejaba en texto plano.
@riverpod
class SharedPreferencesProvider extends _$SharedPreferencesProvider {
  static const _storage = FlutterSecureStorage();

  @override
  Future<FlutterSecureStorage> build() async => _storage;

  /// Método que almacena un String.
  Future<void> saveString({required String key, required String value}) async {
    if (key.isNotEmpty && value.isNotEmpty) {
      try {
        await _storage.write(key: key, value: value);
      } catch (e) {
        ref
            .read(errorProviderProvider.notifier)
            .setError("Error al intentar guardar en memoria.");
      }
    }
  }

  /// Método que extrae un String.
  Future<String?> getString({required String key}) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      ref
          .read(errorProviderProvider.notifier)
          .setError("Error al intentar obtener de memoria.");
      return null;
    }
  }

  /// Método que elimina un String.
  Future<void> removeString({required String key}) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      ref
          .read(errorProviderProvider.notifier)
          .setError("Error al intentar eliminar de memoria.");
    }
  }
}
