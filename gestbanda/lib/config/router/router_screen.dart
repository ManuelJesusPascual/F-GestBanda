import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../screen/pages.dart';

final appRouter = GoRouter(
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

class RouterSimpleCubit extends Cubit<GoRouter> {
  RouterSimpleCubit() : super(appRouter);
  void goBack() {
    state.pop();
  }

  void pushRoute(String route) {
    state.push(route);
  }
}
