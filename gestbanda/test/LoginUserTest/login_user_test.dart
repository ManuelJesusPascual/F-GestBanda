import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestbanda/domain/newmodels/userModels/login_user_dto.dart';
import 'package:gestbanda/presentation/providers/loginProvider/login_provider.dart';

import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
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

// Creamos una versión mock de LoginProvider para usarla en las pruebas
class LoginProviderMock extends LoginProvider {
  @override
  LoginUserDTO build() => LoginUserDTO(
        email: "",
        password: "",
      );
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
        loginProviderProvider.overrideWith(() => LoginProviderMock()),
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
    final proveedorRegistro = contenedor.read(loginProviderProvider.notifier);
    // Verifica que todos los campos estén vacíos inicialmente
    expect(proveedorRegistro.state.email, '',
        reason: 'El email debe estar vacío inicialmente');
    expect(proveedorRegistro.state.password, '',
        reason: 'La contraseña debe estar vacía inicialmente');
  });

  // Grupo de pruebas para los métodos de cambio de campo
  group('Métodos de cambio de campo', () {
    test('changeEmail actualiza el correo electrónico', () {
      final proveedorRegistro = contenedor.read(loginProviderProvider.notifier);
      proveedorRegistro.changeEmail('juan@ejemplo.com');
      expect(proveedorRegistro.state.email, 'juan@ejemplo.com',
          reason: 'El email debe actualizarse correctamente');
    });

    test('changePassword actualiza la contraseña', () {
      final proveedorRegistro = contenedor.read(loginProviderProvider.notifier);
      proveedorRegistro.changePassword('Contraseña123!');
      expect(proveedorRegistro.state.password, 'Contraseña123!',
          reason: 'La contraseña debe actualizarse correctamente');
    });
  });

  // Grupo de pruebas para los métodos de validación
  group('Métodos de validación', () {
    test('validateEmail devuelve null para un correo electrónico válido', () {
      final proveedorRegistro = contenedor.read(loginProviderProvider.notifier);
      expect(proveedorRegistro.validateEmail('juan@ejemplo.com'), isNull,
          reason: 'Un email válido debe pasar la validación');
    });

    test(
        'validateEmail devuelve mensaje de error para un correo electrónico inválido',
        () {
      final proveedorRegistro = contenedor.read(loginProviderProvider.notifier);
      expect(proveedorRegistro.validateEmail('correo-invalido'), isNotNull,
          reason: 'Un email inválido debe fallar la validación');
    });
  });
}
