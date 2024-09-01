import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'config/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation
        .portraitUp, //Hace que no se pueda poner la aplicación en horizontal
  ]);
  initializeDateFormatting().then((_) => runApp(const ProviderScope(
      child:
          MainApp()))); //El initializeDateFormatting para que el calendario pueda estar en español
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      locale: const Locale('es', 'ES'),
      theme: theme,
      darkTheme: darkTheme,
      routerConfig: appRouter,
    );
  }
}
