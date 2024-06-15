import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/screen/onBoardingPages/create_new_band_page_one.dart';
import 'package:gestbanda/screen/onBoardingPages/join_band_page.dart';
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
      path: '/registerScreen',
      builder: (context, state) => const RegisterScreen(),
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
  ],
);

class RouterSimpleCubit extends Cubit<GoRouter> {
  RouterSimpleCubit(super.router);
  void goBack() {
    state.pop();
  }

  void pushRoute(String route) {
    state.push(route);
  }

  void changeRouter(GoRouter router) {
    emit(router);
  }
}
