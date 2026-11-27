import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:gestbanda/domain/newmodels/roleModels/role_dto.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:gestbanda/domain/newmodels/voiceModels/voice_dto.dart';
import 'package:gestbanda/presentation/providers/registerBandProvider/register_band_provider.dart';
import 'package:gestbanda/presentation/providers/sharedPreferencesProvider/shared_preferences_provider.dart';
import 'package:gestbanda/presentation/providers/errorProvider/error_provider.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Mock class for FlutterSecureStorage to simulate its behavior in tests.
class MockSecureStorage extends Mock implements FlutterSecureStorage {}

// Mock class for http.Client to simulate HTTP requests in tests.
class MockHttp extends Mock implements http.Client {}

// Mock class for ImagePicker to simulate image picking in tests.
class MockImagePicker extends Mock implements ImagePicker {}

// Mock class for XFile to represent an image file in tests.
class MockXFile extends Mock implements XFile {}

// Mock class for MultipartRequest to simulate multipart requests in tests.
class MockMultipartRequest extends Mock implements http.MultipartRequest {}

// Mock class for BaseRequest to simulate base requests in tests.
class MockBaseRequest extends Mock implements http.BaseRequest {}

// Mock listener class for testing purposes.
class Listener<T> extends Mock {
  void call(T? previous, T? next);
}

// Mock implementation of SharedPreferencesProvider for testing.
class MockSharedPreferencesProvider
    extends AutoDisposeAsyncNotifier<FlutterSecureStorage>
    implements SharedPreferencesProvider {
  final FlutterSecureStorage mockPrefs;

  MockSharedPreferencesProvider(this.mockPrefs);

  // Builds the mock shared preferences provider.
  @override
  Future<FlutterSecureStorage> build() async {
    return mockPrefs;
  }

  // Saves a string value to shared preferences.
  @override
  Future<void> saveString({required String key, required String value}) async {
    await mockPrefs.write(key: key, value: value);
  }

  // Retrieves a string value from shared preferences.
  @override
  Future<String?> getString({required String key}) async {
    return mockPrefs.read(key: key);
  }

  // Removes a string value from shared preferences.
  @override
  Future<void> removeString({required String key}) async {
    await mockPrefs.delete(key: key);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container; // Provider container for managing state.
  late MockSecureStorage mockPrefs; // Mocked shared preferences.
  late MockHttp mockHttp; // Mocked HTTP client.
  late MockImagePicker mockImagePicker; // Mocked image picker.

  setUpAll(() {
    registerFallbackValue(MockBaseRequest());
  });

  setUp(() {
    mockPrefs = MockSecureStorage();
    mockHttp = MockHttp();
    mockImagePicker = MockImagePicker();

    // Set up channel for ImagePicker
    const MethodChannel channel =
        MethodChannel('plugins.flutter.io/image_picker');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'pickImage') {
        return '/test/path/image.jpg';
      }
      return null;
    });

    container = ProviderContainer(
      overrides: [
        sharedPreferencesProviderProvider
            .overrideWith(() => MockSharedPreferencesProvider(mockPrefs)),
      ],
    );

    // Set up default mock for user data
    final userJson = {
      'id': '123',
      'name': 'Test User',
      'email': 'test@test.com',
      'phone': '123456789',
      'token': 'test-token'
    };
    when(() => mockPrefs.read(key: 'user'))
        .thenAnswer((_) async => jsonEncode(userJson));

    // Clean up after tests
    addTearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
      container.dispose();
    });
  });

  group('Pruebas de RegisterBandProvider', () {
    // Test the initial state of the RegisterBandProvider
    test('El estado inicial debe estar vacío', () async {
      final state = container.read(registerBandProviderProvider);

      expect(state.name, equals(''));
      expect(state.user.id, equals(''));
      expect(state.img.path, equals(''));
    });

    group('Pruebas de changeName', () {
      // Test changing the band name with a new value
      test('debe actualizar el nombre cuando se proporciona un valor diferente',
          () {
        final provider = container.read(registerBandProviderProvider.notifier);

        provider.changeName('New Band Name');
        final state = container.read(registerBandProviderProvider);

        expect(state.name, equals('New Band Name'));
      });

      // Test that the state does not change when the same name is provided
      test('no debe actualizar el estado cuando se proporciona el mismo nombre',
          () {
        final provider = container.read(registerBandProviderProvider.notifier);

        provider.changeName('Band Name');
        final initialState = container.read(registerBandProviderProvider);
        provider.changeName('Band Name');
        final newState = container.read(registerBandProviderProvider);

        expect(newState, equals(initialState));
      });
    });

    group('Pruebas de validateBandName', () {
      // Test that a valid band name returns null
      test('debe devolver null para un nombre de banda válido', () {
        final provider = container.read(registerBandProviderProvider.notifier);

        expect(provider.validateBandName('Valid Band Name'), isNull);
      });

      // Test that an invalid band name returns an error message
      test('debe devolver un mensaje de error para un nombre de banda inválido',
          () {
        final provider = container.read(registerBandProviderProvider.notifier);

        expect(provider.validateBandName(''),
            equals('Debes introducir un nombre de banda válido'));
      });
    });

    group('Pruebas de getUser', () {
      // Test that the user state is updated from FlutterSecureStorage
      test('debe actualizar el estado con el usuario de FlutterSecureStorage',
          () async {
        final userJson = {
          'id': '123',
          'name': 'Test User',
          'email': 'test@test.com',
          'phone': '123456789',
          'token': 'test-token'
        };

        when(() => mockPrefs.read(key: 'user'))
            .thenAnswer((_) async => jsonEncode(userJson));

        final provider = container.read(registerBandProviderProvider.notifier);
        await provider.getUser();
        final state = container.read(registerBandProviderProvider);

        expect(state.user.id, equals('123'));
        expect(state.user.name, equals('Test User'));
        expect(state.user.email, equals('test@test.com'));

        verify(() => mockPrefs.read(key: 'user')).called(1);
      });

      // Test that an error is set when the user is not found in FlutterSecureStorage
      test(
          'debe establecer un error cuando no se encuentra el usuario en FlutterSecureStorage',
          () async {
        when(() => mockPrefs.read(key: 'user')).thenAnswer((_) async => null);

        final provider = container.read(registerBandProviderProvider.notifier);
        await provider.getUser();

        final error = container.read(errorProviderProvider);
        expect(error, equals('No se ha encontrado la sesión del usuario.'));

        verify(() => mockPrefs.read(key: 'user')).called(1);
      });
    });

    group('Pruebas de selectImage', () {
      // Test that the state is updated when an image is selected
      test('debe actualizar el estado cuando se selecciona una imagen',
          () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/test/path/image.jpg');
        when(() => mockImagePicker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 25)).thenAnswer((_) async => mockFile);

        final provider = container.read(registerBandProviderProvider.notifier);
        await provider.selectImage();
        final state = container.read(registerBandProviderProvider);

        expect(state.img.path, equals('/test/path/image.jpg'));
      });
    });

    group('Pruebas de validateImage', () {
      // Test that true is returned when an image is selected
      test('debe devolver true cuando se selecciona una imagen', () {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/test/path/image.jpg');

        final provider = container.read(registerBandProviderProvider.notifier);
        provider.state = provider.state.copyWith(img: mockFile);

        expect(provider.validateImage(), isTrue);
      });

      // Test that false is returned and an error is set when no image is selected
      test(
          'debe devolver false y establecer un error cuando no se selecciona ninguna imagen',
          () {
        final provider = container.read(registerBandProviderProvider.notifier);

        expect(provider.validateImage(), isFalse);
        final error = container.read(errorProviderProvider);
        expect(error, equals('Debes introducir una imagen.'));
      });
    });

    group('Pruebas de registerBand', () {
      setUp(() {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/test/path/image.jpg');

        final provider = container.read(registerBandProviderProvider.notifier);
        provider.state = provider.state.copyWith(
            name: 'Test Band',
            img: mockFile,
            user: UserDTO(
                id: '123',
                name: 'Test User',
                email: 'test@test.com',
                phone: '123456789',
                img: 'test-image.jpg',
                token: 'test-token',
                role: RoleDTO(id: "id", name: "DIRECTOR", router: ""),
                voz: VoiceDTO(id: "1", name: 'Test Voice'),
                instrumentList: [],
                costumeList: []));

        // Setup mock for storing band data
        when(() => mockPrefs.write(
            key: any(named: 'key'),
            value: any(named: 'value'))).thenAnswer((_) async {});
      });

      // Test that the band is successfully registered
      test('debe registrar la banda con éxito', () async {
        final response = http.Response(
            jsonEncode(
                {'id': '1', 'name': 'Test Band', 'image': 'test-image.jpg'}),
            201);

        // Set up the mock response
        when(() => mockHttp.send(any())).thenAnswer((_) async =>
            http.StreamedResponse(
                Stream.value(response.bodyBytes), response.statusCode));

        final provider = container.read(registerBandProviderProvider.notifier);
        await provider.registerBand();
      });

      // Test that an error response is handled correctly
      test('debe manejar la respuesta de error', () async {
        final response = http.Response(
            jsonEncode({'message': 'Error registering band'}), 400);

        // Set up the mock response
        when(() => mockHttp.send(any())).thenAnswer((_) async =>
            http.StreamedResponse(
                Stream.value(response.bodyBytes), response.statusCode));

        final provider = container.read(registerBandProviderProvider.notifier);
        await provider.registerBand();

        final error = container.read(errorProviderProvider);
        expect(
            error,
            equals(
                'Ha ocurrido un error en la aplicacion. Intentalo más tarde.'));

        // Verify the user is fetched
        verify(() => mockPrefs.read(key: 'user')).called(1);
      });

      // Test that network errors are handled correctly
      test('debe manejar errores de red', () async {
        when(() => mockHttp.send(any())).thenThrow(Exception('Network error'));

        final provider = container.read(registerBandProviderProvider.notifier);
        await provider.registerBand();

        final error = container.read(errorProviderProvider);
        expect(
            error,
            equals(
                'Ha ocurrido un error en la aplicacion. Intentalo más tarde.'));
        verify(() => mockPrefs.read(key: 'user')).called(1);
      });
    });
  });
}
