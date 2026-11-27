// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_preferences_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesProviderHash() =>
    r'0d27c423278e949c80284b389f1176de2fda38b3';

/// Provider que usaremos para manejar el almacenamiento local de la sesión
/// (usuario con su token y banda actual).
///
/// Mantiene el nombre original, pero guarda los datos con
/// flutter_secure_storage (Keychain en iOS, cifrado con Android Keystore)
/// en lugar de SharedPreferences, que los dejaba en texto plano.
///
/// Copied from [SharedPreferencesProvider].
@ProviderFor(SharedPreferencesProvider)
final sharedPreferencesProviderProvider = AutoDisposeAsyncNotifierProvider<
    SharedPreferencesProvider, FlutterSecureStorage>.internal(
  SharedPreferencesProvider.new,
  name: r'sharedPreferencesProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SharedPreferencesProvider
    = AutoDisposeAsyncNotifier<FlutterSecureStorage>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
