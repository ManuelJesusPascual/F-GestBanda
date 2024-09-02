import 'package:gestbanda/presentation/providers/errorProvider/error_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_provider.g.dart';

@riverpod
class SharedPreferencesProvider extends _$SharedPreferencesProvider {
  @override
  Future<SharedPreferences> build() async {
    return await SharedPreferences.getInstance();
  }

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
