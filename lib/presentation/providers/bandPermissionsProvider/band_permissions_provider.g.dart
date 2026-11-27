// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'band_permissions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bandPermissionsHash() => r'ef66cb8830083c2d72dbdbaeacb71cc0eaa39948';

/// Permissions of the logged-in user in the stored band, from the `role` and
/// `voice` that getUserBands returns for that band.
///
/// Kept alive for the session; AppRouter.changeRouter invalidates it on
/// login, logout and band changes.
///
/// Copied from [bandPermissions].
@ProviderFor(bandPermissions)
final bandPermissionsProvider = FutureProvider<BandPermissions>.internal(
  bandPermissions,
  name: r'bandPermissionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bandPermissionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BandPermissionsRef = FutureProviderRef<BandPermissions>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
