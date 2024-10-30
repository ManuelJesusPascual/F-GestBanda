// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_preferences_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesProviderHash() =>
    r'6b4ade257d0c270396d527823d2ac81d9faba6b0';

/// Provider que usaremos para manejar las SharedPreferences.
///
/// Copied from [SharedPreferencesProvider].
@ProviderFor(SharedPreferencesProvider)
final sharedPreferencesProviderProvider = AutoDisposeAsyncNotifierProvider<
    SharedPreferencesProvider, SharedPreferences>.internal(
  SharedPreferencesProvider.new,
  name: r'sharedPreferencesProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SharedPreferencesProvider
    = AutoDisposeAsyncNotifier<SharedPreferences>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
