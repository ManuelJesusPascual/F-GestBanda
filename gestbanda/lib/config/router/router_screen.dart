import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../screen/pages.dart';

final appRouter = GoRouter(
  initialLocation: '/initialRoute',
  routes: [
    GoRoute(
      path: '/initialRoute',
      builder: (context, state) => const InitialPage(),
    ),
  ],
);

class RouterSimpleCubit extends Cubit<GoRouter> {
  RouterSimpleCubit() : super(appRouter);
}
