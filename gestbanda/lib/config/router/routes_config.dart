import 'dart:async';
import 'dart:convert';

import 'package:gestbanda/domain/models/costume.dart';
import 'package:gestbanda/domain/models/event.dart';
import 'package:gestbanda/domain/models/instrument.dart';
import 'package:gestbanda/domain/models/user.dart';
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

final authenticatedRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RegisterSelectorPage(),
    ),
    GoRoute(
      path: '/join_band',
      builder: (context, state) => const JoinBandPage(),
    ),
    GoRoute(
      path: '/create_band_one',
      builder: (context, state) => const CreateNewBandPageOne(),
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
        final User user = state.extra
            as User; // This parameter is mandatory unlike others which are optional because the views for create and modify are reused.
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

@riverpod
class AppRouter extends _$AppRouter {
  StreamSubscription<String?>? _userSubscription;

  @override
  Future<GoRouter> build() async {
    // Initialize the router based on the current state
    GoRouter initialRouter = await _determineInitialRouter();

    // Set up the stream to listen for changes in SharedPreferences
    // _setupUserListener();

    return initialRouter;
  }

  Future<GoRouter> _determineInitialRouter() async {
    UserDTO? user = await loadUser();
    return user != null ? authenticatedRouter : unauthenticatedRouter;
  }

  void _setupUserListener() {
    _userSubscription?.cancel();
    _userSubscription = _createUserStream().listen((userJson) {
      if (userJson == null) {
        // The user has been deleted, switch to unauthenticatedRouter
        changeRouter(unauthenticatedRouter);
      } else {
        // The user exists, switch to authenticatedRouter
        changeRouter(authenticatedRouter);
      }
    });
  }

  Stream<String?> _createUserStream() async* {
    while (true) {
      yield await ref
          .read(sharedPreferencesProviderProvider.notifier)
          .getString(key: "user");
      await Future.delayed(const Duration(seconds: 1));
    }
  }

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

  void changeRouter(GoRouter router) {
    state = AsyncValue.data(router);
  }
}
