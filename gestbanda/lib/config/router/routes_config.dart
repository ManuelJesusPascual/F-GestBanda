import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/models/costume.dart';
import 'package:gestbanda/models/event.dart';
import 'package:gestbanda/models/instrument.dart';
import 'package:gestbanda/models/user.dart';
import 'package:gestbanda/screen/appPages/settingsPage/band_voice_add.dart';
import 'package:gestbanda/screen/appPages/settingsPage/band_voices_page.dart';
import 'package:gestbanda/screen/appPages/settingsPage/edit_user_setting_page.dart';
import 'package:gestbanda/screen/appPages/settingsPage/settings_page.dart';
import 'package:gestbanda/screen/appPages/settingsPage/user_settings_page.dart';
import 'package:gestbanda/screen/appPages/userDetailPage/edit_user_detail_page.dart';
import 'package:gestbanda/screen/appPages/userDetailPage/user_costume_create_page.dart';
import 'package:gestbanda/screen/appPages/userDetailPage/user_costume_modify_page.dart';
import 'package:gestbanda/screen/appPages/userDetailPage/user_instrument_create_page.dart';
import 'package:gestbanda/screen/appPages/userDetailPage/user_instrument_modify_page.dart';
import 'package:gestbanda/screen/appPages/userListPage/new_user_list_page.dart';
import 'package:gestbanda/screen/onBoardingPages/create_new_band_page_two.dart';
import 'package:go_router/go_router.dart';

import '../../models/band.dart';
import '../../models/code.dart';
import '../../screen/appPages/settingsPage/band_settings_page.dart';
import '../../screen/appPages/settingsPage/edit_band_setting_page.dart';
import '../../screen/pages.dart';

final unauthenticatedRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const InitialPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
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
      builder: (context, state) => const NewHomePage(),
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
      builder: (context, state) => const NewUserList(),
    ),
    GoRoute(
      path: '/user_detail',
      builder: (context, state) {
        final User user = state.extra
            as User; //Este parámetro a diferencia de los otros que son opcionales porque se reutilizan las vistas de crear y modificar, este es obligatorio.
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
      builder: (context, state) => NewInstrumentPage(),
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

class RouterSimpleCubit extends Cubit<GoRouter> {
  RouterSimpleCubit(super.router);
  void goBack() {
    state.pop();
  }

  void pushRoute(String route, {Object? extra}) {
    state.push(route, extra: extra);
  }

  void go(String route, {Object? extra}) {
    state.go(route, extra: extra);
  }

  void changeRouter(GoRouter router) {
    emit(router);
  }
}
