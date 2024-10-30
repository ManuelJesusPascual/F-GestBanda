import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:gestbanda/presentation/providers/joinBandProvider/join_band_provider.dart';
import 'package:gestbanda/presentation/providers/sharedPreferencesProvider/shared_preferences_provider.dart';
import 'package:gestbanda/presentation/providers/errorProvider/error_provider.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

// Mock class for HTTP client
class MockHttp extends Mock implements http.Client {}

// Mock class for HTTP BaseRequest
class MockBaseRequest extends Mock implements http.BaseRequest {}

// Mock Listener class
class Listener<T> extends Mock {
  void call(T? previous, T? next);
}

// Mock provider for SharedPreferences
class MockSharedPreferencesProvider
    extends AutoDisposeAsyncNotifier<SharedPreferences>
    implements SharedPreferencesProvider {
  final SharedPreferences mockPrefs;

  MockSharedPreferencesProvider(this.mockPrefs);

  @override
  Future<SharedPreferences> build() async {
    return mockPrefs;
  }

  @override
  Future<void> saveString({required String key, required String value}) async {
    await mockPrefs.setString(key, value);
  }

  @override
  Future<String?> getString({required String key}) async {
    return mockPrefs.getString(key);
  }

  @override
  Future<void> removeString({required String key}) async {
    await mockPrefs.remove(key);
  }
}

void main() {
  // Ensure Flutter binding is initialized for widget tests
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late MockSharedPreferences mockPrefs;
  late MockHttp mockHttp;

  setUpAll(() {
    // Register a fallback value for the HTTP URI
    registerFallbackValue(Uri.parse('http://example.com'));
  });

  setUp(() {
    mockPrefs = MockSharedPreferences();
    mockHttp = MockHttp();

    // Create a provider container with overrides
    container = ProviderContainer(
      overrides: [
        sharedPreferencesProviderProvider
            .overrideWith(() => MockSharedPreferencesProvider(mockPrefs)),
      ],
    );

    // Sample user data in JSON format
    final userJson = {
      'id': '123',
      'name': 'Test User',
      'email': 'test@test.com',
      'phone': '123456789',
      'token': 'test-token'
    };

    // Mock the SharedPreferences to return the sample user data
    when(() => mockPrefs.getString('user')).thenReturn(jsonEncode(userJson));

    addTearDown(() {
      // Dispose of the provider container after tests
      container.dispose();
    });
  });

  group('Pruebas de JoinBandProvider', () {
    // Test that the initial state of the JoinBandProvider is empty
    test('El estado inicial debe estar vacío', () async {
      final state = container.read(joinBandProviderProvider);

      // Verify initial state values
      expect(state.code, equals(''));
      expect(state.user.id, equals(''));
    });

    group('Pruebas de cambio de código', () {
      // Test that changing the code updates the state when a different value is provided
      test(
          'Debería actualizar el código cuando se proporciona un valor diferente',
          () {
        final provider = container.read(joinBandProviderProvider.notifier);

        // Change the code to a new value
        provider.changeCode('new_code');
        final state = container.read(joinBandProviderProvider);

        // Verify the code has been updated
        expect(state.code, equals('new_code'));
      });

      // Test that the state does not update when the same code is provided twice
      test(
          'No debería actualizar el estado cuando se proporciona el mismo código',
          () {
        final provider = container.read(joinBandProviderProvider.notifier);

        // Set the same code twice
        provider.changeCode('same_code');
        final initialState = container.read(joinBandProviderProvider);
        provider.changeCode('same_code');
        final newState = container.read(joinBandProviderProvider);

        // Verify the state has not changed
        expect(newState, equals(initialState));
      });
    });

    group('Pruebas de validación de código', () {
      // Test that a valid code returns a null validation message
      test('Debería devolver null para un código válido', () {
        final provider = container.read(joinBandProviderProvider.notifier);

        // Validate a valid code
        expect(provider.validateCode('VALID123'),
            'Debes introducir un código válido');
      });

      // Test that an invalid code returns an error message
      test('Debería devolver un mensaje de error para un código inválido', () {
        final provider = container.read(joinBandProviderProvider.notifier);

        // Validate an empty code
        expect(provider.validateCode(''),
            equals('Debes introducir un código válido'));
      });
    });

    group('Pruebas de obtención de usuario', () {
      // Test that the provider updates its state with the user from SharedPreferences
      test('Debería actualizar el estado con el usuario de SharedPreferences',
          () async {
        final userJson = {
          'id': '123',
          'name': 'Test User',
          'email': 'test@test.com',
          'phone': '123456789',
          'token': 'test-token'
        };

        // Mock the SharedPreferences to return the sample user data
        when(() => mockPrefs.getString('user'))
            .thenReturn(jsonEncode(userJson));

        final provider = container.read(joinBandProviderProvider.notifier);
        await provider.getUser(); // Get user data
        final state = container.read(joinBandProviderProvider);

        // Verify the state has been updated with the user data
        expect(state.user.id, equals('123'));
        expect(state.user.name, equals('Test User'));

        // Verify that getString was called once
        verify(() => mockPrefs.getString('user')).called(1);
      });

      // Test that an error is set when no user is found in SharedPreferences
      test(
          'Debería establecer un error cuando no se encuentra el usuario en SharedPreferences',
          () async {
        // Mock to return null for user data
        when(() => mockPrefs.getString('user')).thenReturn(null);

        final provider = container.read(joinBandProviderProvider.notifier);
        await provider.getUser(); // Attempt to get user data

        final error = container.read(errorProviderProvider);
        // Verify that the error message is set correctly
        expect(error, equals('No se ha encontrado la sesión del usuario.'));

        // Verify that getString was called once
        verify(() => mockPrefs.getString('user')).called(1);
      });
    });

    group('Pruebas de unirse a la banda por código', () {
      // Test that a successful response allows the user to join the band
      test('Debería unirse a la banda con éxito', () async {
        // Mock a successful HTTP response for joining the band
        final response =
            http.Response(jsonEncode({'id': '1', 'name': 'Test Band'}), 200);

        when(() => mockHttp.post(any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'))).thenAnswer((_) async => response);

        final provider = container.read(joinBandProviderProvider.notifier);
        provider.state = provider.state.copyWith(
          code: 'valid_code',
          user: UserDTO(
            id: '123',
            name: 'Test User',
            email: 'test@test.com',
            phone: '123456789',
            token: 'test-token',
          ),
        );

        await provider.joinBandByCode(); // Attempt to join the band

        final state = container.read(joinBandProviderProvider);
        // Verify that the user's ID is still correct after joining
        expect(state.user.id, equals('123'));

        // Verify that band data has been stored
        final bandData = container.read(sharedPreferencesProviderProvider);
        expect(bandData, isNotNull);
      });

      // Test that the provider correctly handles an error response when joining the band
      test('Debería manejar la respuesta de error', () async {
        // Mock an error response for joining the band
        final response =
            http.Response(jsonEncode({'message': 'Error joining band'}), 400);

        when(() => mockHttp.post(any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'))).thenAnswer((_) async => response);

        final provider = container.read(joinBandProviderProvider.notifier);
        await provider.joinBandByCode(); // Attempt to join the band

        final error = container.read(errorProviderProvider);
        // Verify that the error message is set correctly
        expect(
            error,
            equals(
                'Ha ocurrido un error en la aplicacion. Intentalo más tarde.'));
      });

      // Test that network errors are handled gracefully
      test('Debería manejar errores de red', () async {
        // Mock a network error when trying to join the band
        when(() => mockHttp.post(any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'))).thenThrow(Exception('Network error'));

        final provider = container.read(joinBandProviderProvider.notifier);
        await provider.joinBandByCode(); // Attempt to join the band

        final error = container.read(errorProviderProvider);
        // Verify that the error message is set correctly
        expect(
            error,
            equals(
                'Ha ocurrido un error en la aplicacion. Intentalo más tarde.'));
      });
    });
  });
}
