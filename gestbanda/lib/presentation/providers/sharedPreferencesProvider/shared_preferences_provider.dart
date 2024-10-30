import 'package:gestbanda/presentation/providers/errorProvider/error_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_provider.g.dart';

/// Provider que usaremos para manejar las SharedPreferences.
@riverpod
class SharedPreferencesProvider extends _$SharedPreferencesProvider {
  @override
  Future<SharedPreferences> build() async {
    return await SharedPreferences.getInstance();
  }

  /// Método que almacena un String en SharedPreferences.
  Future<void> saveString({required String key, required String value}) async {
    final prefs = await build();

    if (key.isNotEmpty && value.isNotEmpty) {
      try {
        await prefs.setString(key, value);
        print("Guardado correctamente:");
        print("Clave: $key");
        print("Valor: $value");
      } catch (e) {
        ref
            .read(errorProviderProvider.notifier)
            .setError("Error al intentar guardar en memoria.");
        print("Error al guardar: $e");
      }
    }
  }

  /// Método que extrae un String de SharedPreferences.
  Future<String?> getString({required String key}) async {
    final prefs = await build();

    try {
      return prefs.getString(key);
    } catch (e) {
      ref
          .read(errorProviderProvider.notifier)
          .setError("Error al intentar obtener de memoria.");
      return null;
    }
  }

  /// Método que elimina un String de SharedPreferences.
  Future<void> removeString({required String key}) async {
    final prefs = await build();

    try {
      await prefs.remove(key);
    } catch (e) {
      ref
          .read(errorProviderProvider.notifier)
          .setError("Error al intentar eliminar de memoria.");
    }
  }
}
