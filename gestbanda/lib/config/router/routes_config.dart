import 'dart:async';
import 'dart:convert';

import 'package:gestbanda/domain/models/costume.dart';
import 'package:gestbanda/domain/models/event.dart';
import 'package:gestbanda/domain/models/instrument.dart';
import 'package:gestbanda/domain/models/user.dart';
import 'package:gestbanda/domain/newmodels/bandModels/band_dto.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:gestbanda/presentation/providers/sharedPreferencesProvider/shared_preferences_provider.dart';
import 'package:gestbanda/presentation/screen/appPages/userListPage/user_list_page.dart';
import 'package:gestbanda/presentation/screen/onBoardingPages/create_new_band_page_two.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/band.dart';
import '../../domain/models/code.dart';
import '../../presentation/screen/pages.dart';

part 'routes_config.g.dart';

/// Router configuration for unauthenticated users.
final unauthenticatedRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const InitialPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/private_policy',
      builder: (context, state) => const PrivatePolicy(),
    ),
  ],
);

/// Router configuration for authenticated users without a specific band association.
final authenticatedRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RegisterSelectorPage(),
    ),
    GoRoute(
      path: '/join_band',
      builder: (context, state) => JoinBandPage(),
    ),
    GoRoute(
      path: '/create_band_one',
      builder: (context, state) => CreateNewBandPageOne(),
    ),
    GoRoute(
      path: '/create_band_two',
      builder: (context, state) => const CreateNewBandPageTwo(),
    ),
    GoRoute(
      path: '/return_policy',
      builder: (context, state) => const ReturnPolicy(),
    ),
  ],
);

/// Router configuration for users with director role and specific band association.
final directorRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/calendar',
      builder: (context, state) => const NewCalendarPage(),
    ),
    GoRoute(
      path: '/event_detail',
      builder: (context, state) => EventDetailPage(event: state.extra as Event),
    ),
    GoRoute(
      path: '/event_create_modify',
      builder: (context, state) {
        final Event? event = state.extra as Event?;
        return EventCreateModify(event: event);
      },
    ),
    GoRoute(
      path: '/user_list',
      builder: (context, state) => const UserList(),
    ),
    GoRoute(
      path: '/user_detail',
      builder: (context, state) {
        final User user = state.extra as User;
        return UserDetailPage(
          user: user,
        );
      },
    ),
    GoRoute(
      path: '/user_add_instrument',
      builder: (context, state) {
        return const UserInstrumentCreatePage();
      },
    ),
    GoRoute(
      path: '/user_add_costume',
      builder: (context, state) {
        return const UserCostumeCreatePage();
      },
    ),
    GoRoute(
      path: '/user_modify',
      builder: (context, state) {
        final User user = state.extra as User;
        return EditUserDetailPage(
          user: user,
        );
      },
    ),
    GoRoute(
      path: '/user_instrument_modify',
      builder: (context, state) {
        final Instrument instrument = state.extra as Instrument;
        return UserInstrumentModifyPage(instrument: instrument);
      },
    ),
    GoRoute(
      path: '/user_costume_modify',
      builder: (context, state) {
        final Costume costume = state.extra as Costume;
        return UserCostumeModifyPage(costume: costume);
      },
    ),
    GoRoute(
      path: '/code_list',
      builder: (context, state) => CodeList(),
    ),
    GoRoute(
      path: '/code_create_modify',
      builder: (context, state) {
        final Code? code = state.extra as Code?;
        return CodeCreateModify(code: code);
      },
    ),
    GoRoute(
      path: '/instruments_list',
      builder: (context, state) => InstrumentPage(),
    ),
    GoRoute(
      path: '/instrument_create_modify',
      builder: (context, state) {
        final Instrument? instrument = state.extra as Instrument?;
        return InstrumentCreateModifyPage(instrument: instrument);
      },
    ),
    GoRoute(
      path: '/costume_list',
      builder: (context, state) => NewCustomePage(),
    ),
    GoRoute(
      path: '/costume_create_modify',
      builder: (context, state) {
        final Costume? costume = state.extra as Costume?;
        return CostumeCreateModifyPage(costume: costume);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/user_settings',
      builder: (context, state) {
        final User user = state.extra as User;
        return UserSettingsPage(
          user: user,
        );
      },
    ),
    GoRoute(
      path: '/band_settings',
      builder: (context, state) {
        final Band band = state.extra as Band;
        return BandSettingsPage(
          band: band,
        );
      },
    ),
    GoRoute(
      path: '/edit_user_setting/:setting',
      builder: (context, state) {
        final User user = state.extra as User;
        final String setting = state.pathParameters['setting']!;
        return EditUserSettingPage(
          user: user,
          setting: setting,
        );
      },
    ),
    GoRoute(
      path: '/edit_band_setting/:setting',
      builder: (context, state) {
        final Band band = state.extra as Band;
        final String setting = state.pathParameters['setting']!;
        return EditBandSettingPage(
          band: band,
          setting: setting,
        );
      },
    ),
    GoRoute(
      path: '/edit_band_voices',
      builder: (context, state) {
        return BandVoicesPage();
      },
    ),
    GoRoute(
      path: '/add_band_voices',
      builder: (context, state) {
        return const BandVoiceAddPage();
      },
    ),
    GoRoute(
      path: '/return_policy',
      builder: (context, state) => const ReturnPolicy(),
    ),
    GoRoute(
      path: '/private_policy',
      builder: (context, state) => const PrivatePolicy(),
    ),
  ],
);

/// Riverpod provider for managing the app's router based on user authentication state.
@riverpod
class AppRouter extends _$AppRouter {
  /// Builds the initial GoRouter configuration based on the current user state.
  @override
  Future<GoRouter> build() async {
    GoRouter initialRouter = await _determineInitialRouter();
    return initialRouter;
  }

  /// Determines the initial router configuration based on the user's authentication and band state.
  Future<GoRouter> _determineInitialRouter() async {
    GoRouter router = unauthenticatedRouter;
    UserDTO? user = await loadUser();
    BandDTO? band = await loadBand();
    if (user == null) {
      router = unauthenticatedRouter;
    } else if (band != null) {
      //User will never be null because it has already been checked in the previous if statement.
      router = directorRouter;
    } else {
      router = authenticatedRouter;
    }
    return router;
  }

  /// Loads the user data from shared preferences and decodes the JSON string to a UserDTO object.
  Future<UserDTO?> loadUser() async {
    final String? userJSON = await ref
        .read(sharedPreferencesProviderProvider.notifier)
        .getString(key: "user");
    if (userJSON != null && userJSON.isNotEmpty) {
      try {
        final Map<String, dynamic> userMap = json.decode(userJSON);
        return UserDTO.fromJson(userMap);
      } catch (e) {
        print('Error al decodificar JSON: $e');
      }
    }
    return null;
  }

  /// Loads the band data from shared preferences and decodes the JSON string to a BandDTO object.
  Future<BandDTO?> loadBand() async {
    final String? bandJSON = await ref
        .read(sharedPreferencesProviderProvider.notifier)
        .getString(key: "band");
    if (bandJSON != null && bandJSON.isNotEmpty) {
      try {
        final Map<String, dynamic> bandMap = json.decode(bandJSON);
        return BandDTO.fromJson(bandMap);
      } catch (e) {
        print('Error al decodificar JSON: $e');
      }
    }
    return null;
  }

  /// Updates the app's router state with a new GoRouter configuration.
  void changeRouter(GoRouter router) {
    state = AsyncValue.data(router);
  }
}
