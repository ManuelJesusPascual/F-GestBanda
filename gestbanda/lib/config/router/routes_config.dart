import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/models/Event.dart';
import 'package:gestbanda/screen/onBoardingPages/create_new_band_page_two.dart';
import 'package:go_router/go_router.dart';

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
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: '/return_policy',
      builder: (context, state) => const ReturnPolicy(),
    ),
    GoRoute(
      path: '/private_policy',
      builder: (context, state) => const PrivatePolicy(),
    ),
    GoRoute(
      path: '/event_detail',
      builder: (context, state) => EventDetailPage(event: state.extra as Event),
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

  void changeRouter(GoRouter router) {
    emit(router);
  }
}
