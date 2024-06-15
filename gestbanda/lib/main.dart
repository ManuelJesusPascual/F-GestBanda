import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/blocs/blocs.dart';
import 'package:gestbanda/blocs/registerForm/register_form_bloc_events.dart';
import 'config/config.dart';

void main() {
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RouterSimpleCubit(authenticatedRouter),
        ),
        BlocProvider(
          create: (context) => RegisterFormBloc()..add(const InitEvent()),
        ),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = context.watch<RouterSimpleCubit>().state;

    return MaterialApp.router(
      theme: theme,
      darkTheme: darkTheme,
      routerConfig: appRouter,
    );
  }
}
