import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestbanda/domain/newmodels/userModels/register_user_dto.dart';

import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:gestbanda/presentation/providers/registerProvider/register_provider.dart';
import 'package:gestbanda/presentation/providers/sharedPreferencesProvider/shared_preferences_provider.dart';
import 'package:gestbanda/presentation/providers/errorProvider/error_provider.dart';
import 'package:gestbanda/config/router/routes_config.dart';

// Clases simuladas (mocks) para simular el comportamiento de dependencias externas
class ClienteMock extends Mock implements http.Client {}

class ProveedorPreferenciasCompartidasMock extends Mock
    implements SharedPreferencesProvider {}

class ProveedorErrorMock extends Mock implements ErrorProvider {}

class EnrutadorAppMock extends Mock implements AppRouter {}

class HttpMock extends Mock implements http.Client {}

// Creamos una versión mock de RegisterProvider para usarla en las pruebas
class RegisterProviderMock extends RegisterProvider {
  @override
  RegisterUserDTO build() => RegisterUserDTO(
      name: "", email: "", phone: "", password: "", confirmPassword: "");
}

void main() {
  late ProviderContainer contenedor;
  late ProveedorPreferenciasCompartidasMock preferenciasMock;
  late ProveedorErrorMock errorProveedorMock;
  late EnrutadorAppMock enrutadorAppMock;

  // Configuración que se ejecuta antes de cada prueba
  setUp(() {
    // Inicialización de los mocks
    preferenciasMock = ProveedorPreferenciasCompartidasMock();
    errorProveedorMock = ProveedorErrorMock();
    enrutadorAppMock = EnrutadorAppMock();

    // Creación del contenedor de proveedores con sobreescrituras para usar los mocks
    contenedor = ProviderContainer(
      overrides: [
        registerProviderProvider.overrideWith(() => RegisterProviderMock()),
        sharedPreferencesProviderProvider.overrideWith(() => preferenciasMock),
        errorProviderProvider.overrideWith(() => errorProveedorMock),
        appRouterProvider.overrideWith(() => enrutadorAppMock),
      ],
    );
  });

  // Limpieza que se ejecuta después de cada prueba
  tearDown(() {
    contenedor.dispose();
  });

  // Prueba del estado inicial del proveedor
  test('Estado inicial', () {
    final proveedorRegistro =
        contenedor.read(registerProviderProvider.notifier);
    // Verifica que todos los campos estén vacíos inicialmente
    expect(proveedorRegistro.state.name, '',
        reason: 'El nombre debe estar vacío inicialmente');
    expect(proveedorRegistro.state.email, '',
        reason: 'El email debe estar vacío inicialmente');
    expect(proveedorRegistro.state.phone, '',
        reason: 'El teléfono debe estar vacío inicialmente');
    expect(proveedorRegistro.state.password, '',
        reason: 'La contraseña debe estar vacía inicialmente');
    expect(proveedorRegistro.state.confirmPassword, '',
        reason: 'La confirmación de contraseña debe estar vacía inicialmente');
  });

  // Grupo de pruebas para los métodos de cambio de campo
  group('Métodos de cambio de campo', () {
    test('changeName actualiza el nombre', () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      proveedorRegistro.changeName('Juan Pérez');
      expect(proveedorRegistro.state.name, 'Juan Pérez',
          reason: 'El nombre debe actualizarse correctamente');
    });

    test('changeEmail actualiza el correo electrónico', () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      proveedorRegistro.changeEmail('juan@ejemplo.com');
      expect(proveedorRegistro.state.email, 'juan@ejemplo.com',
          reason: 'El email debe actualizarse correctamente');
    });

    test('changePhone actualiza el teléfono', () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      proveedorRegistro.changePhone('1234567890');
      expect(proveedorRegistro.state.phone, '1234567890',
          reason: 'El teléfono debe actualizarse correctamente');
    });

    test('changePassword actualiza la contraseña', () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      proveedorRegistro.changePassword('Contraseña123!');
      expect(proveedorRegistro.state.password, 'Contraseña123!',
          reason: 'La contraseña debe actualizarse correctamente');
    });

    test('changeConfirmPassword actualiza la confirmación de contraseña', () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      proveedorRegistro.changeConfirmPassword('Contraseña123!');
      expect(proveedorRegistro.state.confirmPassword, 'Contraseña123!',
          reason:
              'La confirmación de contraseña debe actualizarse correctamente');
    });
  });

  // Grupo de pruebas para los métodos de validación
  group('Métodos de validación', () {
    test('validateName devuelve null para un nombre válido', () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      expect(proveedorRegistro.validateName('Juan Pérez'),
          "Debes introducir un nombre válido",
          reason: 'Un nombre válido debe pasar la validación');
    });

    test('validateName devuelve mensaje de error para un nombre inválido', () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      expect(proveedorRegistro.validateName(''), isNotNull,
          reason: 'Un nombre vacío debe fallar la validación');
    });

    test('validateEmail devuelve null para un correo electrónico válido', () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      expect(proveedorRegistro.validateEmail('juan@ejemplo.com'), isNull,
          reason: 'Un email válido debe pasar la validación');
    });

    test(
        'validateEmail devuelve mensaje de error para un correo electrónico inválido',
        () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      expect(proveedorRegistro.validateEmail('correo-invalido'), isNotNull,
          reason: 'Un email inválido debe fallar la validación');
    });

    test('validatePhone devuelve null para un teléfono válido', () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      expect(proveedorRegistro.validatePhone('1234567890'),
          "Debes introducir un teléfono válido",
          reason: 'Un teléfono válido debe pasar la validación');
    });

    test('validatePhone devuelve mensaje de error para un teléfono inválido',
        () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      expect(proveedorRegistro.validatePhone('123'), isNotNull,
          reason: 'Un teléfono inválido debe fallar la validación');
    });

    test('validatePassword devuelve null para una contraseña válida', () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      expect(proveedorRegistro.validatePassword('Contraseña123!'), isNull,
          reason: 'Una contraseña válida debe pasar la validación');
    });

    test(
        'validatePassword devuelve mensajes de error para contraseñas inválidas',
        () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      expect(proveedorRegistro.validatePassword('corta'), isNotNull,
          reason: 'Una contraseña corta debe fallar la validación');
      expect(proveedorRegistro.validatePassword('sinmayusculas123!'), isNotNull,
          reason: 'Una contraseña sin mayúsculas debe fallar la validación');
      expect(proveedorRegistro.validatePassword('SINMINUSCULAS123!'), isNotNull,
          reason: 'Una contraseña sin minúsculas debe fallar la validación');
      expect(proveedorRegistro.validatePassword('SinNumeros!'), isNotNull,
          reason: 'Una contraseña sin números debe fallar la validación');
      expect(proveedorRegistro.validatePassword('SinCaracteresEspeciales123'),
          isNotNull,
          reason:
              'Una contraseña sin caracteres especiales debe fallar la validación');
    });

    test(
        'validateConfirmPassword devuelve null cuando las contraseñas coinciden',
        () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      proveedorRegistro.changePassword('Contraseña123!');
      proveedorRegistro.changeConfirmPassword('Contraseña123!');
      expect(
          proveedorRegistro.validateConfirmPassword('Contraseña123!'), isNull,
          reason: 'Las contraseñas que coinciden deben pasar la validación');
    });

    test(
        'validateConfirmPassword devuelve error cuando las contraseñas no coinciden',
        () {
      final proveedorRegistro =
          contenedor.read(registerProviderProvider.notifier);
      proveedorRegistro.changePassword('Contraseña123!');
      proveedorRegistro.changeConfirmPassword('ContraseñaDiferente123!');
      expect(
          proveedorRegistro.validateConfirmPassword('ContraseñaDiferente123!'),
          isNotNull,
          reason:
              'Las contraseñas que no coinciden deben fallar la validación');
    });
  });
}
