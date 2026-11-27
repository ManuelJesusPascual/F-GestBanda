/// Base URL of the GestBanda backend.
///
/// Override at build time, e.g.
/// `flutter run --dart-define=API_BASE_URL=http://192.168.1.10:3000`.
/// The default points to the host machine from the Android emulator.
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:3000',
);

/// Root of the REST API; every endpoint lives under `/api`.
const String apiUrl = '$apiBaseUrl/api';
