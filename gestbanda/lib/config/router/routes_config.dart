import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/models/Costume.dart';
import 'package:gestbanda/models/Event.dart';
import 'package:gestbanda/models/Instrument.dart';
import 'package:gestbanda/models/User.dart';
import 'package:gestbanda/screen/appPages/calendarPage/new_calendar_page.dart';
import 'package:gestbanda/screen/appPages/costumesPages/costumes_list_page%20.dart';
import 'package:gestbanda/screen/appPages/homePage/new_home_page.dart';
import 'package:gestbanda/screen/appPages/instrumentsPages/instrument_create_modify_page.dart';
import 'package:gestbanda/screen/appPages/instrumentsPages/new_instrument_page.dart';
import 'package:gestbanda/screen/appPages/userDetailPage/user_detail_page.dart';
import 'package:gestbanda/screen/appPages/userListPage/new_user_list_page.dart';
import 'package:gestbanda/screen/onBoardingPages/create_new_band_page_two.dart';
import 'package:go_router/go_router.dart';

import '../../models/Code.dart';
import '../../screen/appPages/costumesPages/costumes_create_modify_page.dart';
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
