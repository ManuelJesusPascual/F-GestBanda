**English** | [Español](README.es.md)

# F-GestBanda

[![CI](https://github.com/ManuelJesusPascual/F-GestBanda/actions/workflows/ci.yml/badge.svg)](https://github.com/ManuelJesusPascual/F-GestBanda/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Flutter mobile client of **GestBanda**, an app to manage marching bands
(Spanish *bandas cofrades*): members, voices, invitation codes and roles.

The REST API lives in a separate repository:
**[B-GestBanda](https://github.com/ManuelJesusPascual/B-GestBanda)** (Java, Spring Boot).

## Why

Bands of this kind usually run on spreadsheets and group chats: who plays which
voice, who has joined this season, who has borrowed which uniform. GestBanda
gives the band director one place to manage the band, and members an easy way
to join with an invitation code.

## Features

Connected to the API:

- User registration and login (token-based auth).
- Create a band with a name and logo, or join one with an invitation code.
- Invitation codes: create, edit, delete, set the expiry date and the voice.
- Band voices: list, add, remove.
- Members: list, view details, change role and voice, remove from the band.
- Session restore on start-up, with a different route tree for each state:
  logged out, logged in without a band, and member of a band.

UI preview with sample data (no API behind it yet, marked in the app with a
banner): events and calendar, uniforms (costumes) and instruments. See the
[roadmap](#roadmap).

## Tech stack

| Area | Choice |
|---|---|
| Framework | Flutter 3.27 / Dart 3.6 |
| State management | Riverpod 2 with `riverpod_generator` (code generation) |
| Navigation | `go_router` |
| HTTP | `http` |
| Session storage | `flutter_secure_storage` (Keychain / Android Keystore) |
| Tests | `flutter_test`, `mockito`, `mocktail` |
| CI | GitHub Actions: format check, `flutter analyze`, `flutter test` |

## Architecture

```
lib/
├── config/
│   ├── api_config.dart      # API base URL (--dart-define)
│   ├── router/              # go_router route trees, picked from the session state
│   └── theme/
├── domain/
│   ├── newmodels/           # DTOs that mirror the API contracts
│   └── models/              # models of the preview features (sample data)
├── presentation/
│   ├── providers/           # Riverpod notifiers: form state, validation, API calls
│   └── screen/              # pages, grouped by flow
├── widgets/                 # reusable UI components
└── utils/
```

Each flow has a Riverpod notifier that holds the form state, validates the
input and calls the API. Errors go to a shared `errorProvider`, and the pages
show them in a snackbar. After login, the token that the API returns in the
`Authorization` response header is stored with the user and sent in the
`Authorization` header of every request.

### Roles and errors

The app reads the user's role in the band from `getUserBands` and hides what
the role does not allow. The API enforces the same rules and answers 403.

| Role | Can do |
|---|---|
| `DIRECTOR` | Manage voices, invitation codes and every member, including roles |
| `JEFE DE VOZ` | Change the voice of, or remove, `COMPONENTE` members of their own voice |
| `COMPONENTE` | Read only. Users who join with a code get this role |

Error responses are handled in one place (`lib/utils/api_errors.dart`): a 401
(`code` 14) closes the session and goes back to the login screen, a 403
(`code` 12) explains that the role does not allow the action, a 5xx shows a
generic message, and any other error shows the message of the API.
Invitation codes are always handled as six-digit text (for example `004821`).

Main endpoints used (all under `/api`):

| Feature | Endpoints |
|---|---|
| Users | `/users/registerUser`, `/users/login`, `/users/getUserByID` |
| Bands | `/band/registerBand`, `/userBands/getUserBands` |
| Codes | `/codes/getBandCodes`, `/codes/createBandCode`, `/codes/updateBandCode`, `/codes/deleteBandCode`, `/codes/joinBandByCode` |
| Voices | `/bandVoices/getVoicesBand`, `/bandVoices/getVoicesBandNotHave`, `/bandVoices/addVoiceToBand`, `/bandVoices/deleteVoiceBand` |
| Members | `/userBands/getBandUsers`, `/userBands/modifyUserBand`, `/userBands/deleteUserBand` |
| Roles | `/roles/getAllRoles` |

## Getting started

### Prerequisites

- Flutter 3.27.x ([install guide](https://docs.flutter.dev/get-started/install)).
- An Android emulator, an iOS simulator or a physical device.
- The backend running on port 3000. See
  [B-GestBanda](https://github.com/ManuelJesusPascual/B-GestBanda) for how to start it.

### Run

```bash
flutter pub get

# Android emulator: the default URL, http://10.0.2.2:3000, reaches the host machine
flutter run

# Physical device or iOS simulator: point the app to your machine
flutter run --dart-define=API_BASE_URL=http://192.168.1.50:3000
```

### Usage example

1. Register, or log in with an existing account.
2. Choose **create a new band** (name and logo) or **join a band** with an
   invitation code.
3. As the director, open the settings to add the band's voices, then create an
   invitation code for each voice and share it with the members.
4. Members who join with a code appear in the member list. From there you can
   change their role and voice.

### Tests and checks

```bash
flutter test
flutter analyze
dart format --output=none --set-exit-if-changed lib test
```

The tests cover the providers: field updates and input validation for
registration, login, band creation and joining a band, plus the success,
error-response and network-error paths of band creation and joining a band.

### Code generation

Providers use `@riverpod` annotations. After changing one, regenerate the
`*.g.dart` files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Roadmap

- Events and calendar connected to the API (create, edit, attendance).
- Uniform and instrument inventory, and loans to members.
- Change the band logo and the profile picture.
- Widget tests for the main flows.

## Documentation

- [Entity-relationship model](https://dbdiagram.io/d/676b8a825406798ef797c0e0)
- [Technical diagram](https://app.eraser.io/workspace/YplnmLy3G8KaqIGRt6Uz?origin=share)

## Credits

- [@ManuelJesusPascual](https://github.com/ManuelJesusPascual): lead developer.
- [@DevJoseEstrada](https://github.com/DevJoseEstrada): project architecture,
  support and best practices.
- Illustrations by [Storyset](https://storyset.com) (Freepik).

## License

[MIT](LICENSE) © Manuel Jesús Pascual
