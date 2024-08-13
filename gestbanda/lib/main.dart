import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/blocs/blocs.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'config/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation
        .portraitUp, //Hace que no se pueda poner la aplicación en horizontal
  ]);
  initializeDateFormatting().then((_) => runApp(
      const BlocsProviders())); //El initializeDateFormatting para que el calendario pueda estar en español
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RouterSimpleCubit(unauthenticatedRouter),
        ),
        BlocProvider(
          create: (context) =>
              RegisterUserFormBloc()..add(const RegisterUserFormInitEvent()),
        ),
        BlocProvider(
          create: (context) =>
              LoginUserFormBloc()..add(const LoginUserFormInitEvent()),
        ),
        BlocProvider(
          create: (context) =>
              RegisterBandFormBloc()..add(const RegisterBandFormInitEvent()),
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
      locale: const Locale('es', 'ES'),
      theme: theme,
      darkTheme: darkTheme,
      routerConfig: appRouter,
    );
  }
}
