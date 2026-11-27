[English](README.md) | **Español**

# F-GestBanda

[![CI](https://github.com/ManuelJesusPascual/F-GestBanda/actions/workflows/ci.yml/badge.svg)](https://github.com/ManuelJesusPascual/F-GestBanda/actions/workflows/ci.yml)
[![Licencia: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Cliente móvil en Flutter de **GestBanda**, una app para gestionar bandas,
principalmente cofrades: componentes, voces, códigos de invitación y roles.

La API REST está en otro repositorio:
**[B-GestBanda](https://github.com/ManuelJesusPascual/B-GestBanda)** (Java, Spring Boot).

## Por qué

Estas bandas suelen gestionarse con hojas de cálculo y grupos de mensajería:
quién toca cada voz, quién se ha incorporado esta temporada, quién tiene
prestado cada traje. GestBanda da al director un único sitio para gestionar la
banda, y a los componentes una forma sencilla de unirse con un código de
invitación.

## Funcionalidades

Conectadas a la API:

- Registro e inicio de sesión de usuarios (autenticación por token).
- Crear una banda con nombre y logo, o unirse a una con un código de invitación.
- Códigos de invitación: crear, editar, eliminar, fijar la fecha de caducidad y la voz.
- Voces de la banda: listar, añadir, quitar.
- Componentes: listar, ver el detalle, cambiar el rol y la voz, quitar de la banda.
- Recuperación de la sesión al arrancar, con un árbol de rutas distinto para
  cada estado: sin sesión, con sesión pero sin banda, y componente de una banda.

Vista previa de interfaz con datos de ejemplo (todavía sin API detrás,
marcada en la app con un aviso): eventos y calendario, trajes e instrumentos.
Ver la [hoja de ruta](#hoja-de-ruta).

## Stack técnico

| Área | Elección |
|---|---|
| Framework | Flutter 3.27 / Dart 3.6 |
| Gestión de estado | Riverpod 2 con `riverpod_generator` (generación de código) |
| Navegación | `go_router` |
| HTTP | `http` |
| Almacenamiento de la sesión | `flutter_secure_storage` (Keychain / Android Keystore) |
| Tests | `flutter_test`, `mockito`, `mocktail` |
| CI | GitHub Actions: formato, `flutter analyze`, `flutter test` |

## Arquitectura

```
lib/
├── config/
│   ├── api_config.dart      # URL base de la API (--dart-define)
│   ├── router/              # árboles de rutas de go_router, según el estado de la sesión
│   └── theme/
├── domain/
│   ├── newmodels/           # DTOs que reflejan los contratos de la API
│   └── models/              # modelos de las funcionalidades en vista previa (datos de ejemplo)
├── presentation/
│   ├── providers/           # notifiers de Riverpod: estado del formulario, validación, llamadas a la API
│   └── screen/              # páginas, agrupadas por flujo
├── widgets/                 # componentes de interfaz reutilizables
└── utils/
```

Cada flujo tiene un notifier de Riverpod que guarda el estado del formulario,
valida la entrada y llama a la API. Los errores van a un `errorProvider`
compartido y las páginas los muestran en un snackbar. Tras el login, el token
que la API devuelve en la cabecera `Authorization` de la respuesta se guarda
con el usuario y se envía en la cabecera `Authorization` de cada petición.

Endpoints principales (todos bajo `/api`):

| Funcionalidad | Endpoints |
|---|---|
| Usuarios | `/users/registerUser`, `/users/login`, `/users/getUserByID` |
| Bandas | `/band/registerBand`, `/userBands/getUserBands` |
| Códigos | `/codes/getBandCodes`, `/codes/createBandCode`, `/codes/updateBandCode`, `/codes/deleteBandCode`, `/codes/joinBandByCode` |
| Voces | `/bandVoices/getVoicesBand`, `/bandVoices/getVoicesBandNotHave`, `/bandVoices/addVoiceToBand`, `/bandVoices/deleteVoiceBand` |
| Componentes | `/userBands/getBandUsers`, `/userBands/modifyUserBand`, `/userBands/deleteUserBand` |
| Roles | `/roles/getAllRoles` |

## Puesta en marcha

### Requisitos

- Flutter 3.27.x ([guía de instalación](https://docs.flutter.dev/get-started/install)).
- Un emulador de Android, un simulador de iOS o un dispositivo físico.
- El backend arrancado en el puerto 3000. Ver en
  [B-GestBanda](https://github.com/ManuelJesusPascual/B-GestBanda) cómo levantarlo.

### Ejecutar

```bash
flutter pub get

# Emulador de Android: la URL por defecto, http://10.0.2.2:3000, apunta a tu máquina
flutter run

# Dispositivo físico o simulador de iOS: indica la IP de tu máquina
flutter run --dart-define=API_BASE_URL=http://192.168.1.50:3000
```

### Ejemplo de uso

1. Regístrate o inicia sesión con una cuenta existente.
2. Elige **crear una banda nueva** (nombre y logo) o **unirte a una banda** con
   un código de invitación.
3. Como director, entra en los ajustes para añadir las voces de la banda y
   crea un código de invitación por voz para compartirlo con los componentes.
4. Quien se une con un código aparece en la lista de componentes. Desde ahí
   puedes cambiar su rol y su voz.

### Tests y comprobaciones

```bash
flutter test
flutter analyze
dart format --output=none --set-exit-if-changed lib test
```

Los tests cubren los providers: actualización de campos y validación de la
entrada del registro, el login, la creación de bandas y la unión a una banda,
y los casos de éxito, respuesta de error y error de red de la creación de
bandas y la unión a una banda.

### Generación de código

Los providers usan anotaciones `@riverpod`. Después de cambiar uno, regenera
los ficheros `*.g.dart`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Hoja de ruta

- Eventos y calendario conectados a la API (crear, editar, asistencia).
- Inventario de trajes e instrumentos, y préstamos a los componentes.
- Cambiar el logo de la banda y la foto de perfil.
- Widget tests de los flujos principales.

## Documentación

- [Modelo entidad-relación](https://dbdiagram.io/d/676b8a825406798ef797c0e0)
- [Diagrama técnico](https://app.eraser.io/workspace/YplnmLy3G8KaqIGRt6Uz?origin=share)

## Créditos

- [@ManuelJesusPascual](https://github.com/ManuelJesusPascual): desarrollador principal.
- [@DevJoseEstrada](https://github.com/DevJoseEstrada): arquitectura del
  proyecto, soporte con dudas y buenas prácticas.
- Ilustraciones de [Storyset](https://storyset.com) (Freepik).

## Licencia

[MIT](LICENSE) © Manuel Jesús Pascual
