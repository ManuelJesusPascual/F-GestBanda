// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginProviderHash() => r'6dd4780d1e2f28efe01a13ef64dd3319b6ec6471';

/// Provider for handling user login operations and managing login state
/// such as email and password, as well as API interactions for user login.
///
/// Copied from [LoginProvider].
@ProviderFor(LoginProvider)
final loginProviderProvider =
    AutoDisposeNotifierProvider<LoginProvider, LoginUserDTO>.internal(
  LoginProvider.new,
  name: r'loginProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loginProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoginProvider = AutoDisposeNotifier<LoginUserDTO>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
