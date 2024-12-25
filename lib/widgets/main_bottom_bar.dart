import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestbanda/config/router/routes_config.dart';

class MainBottomBar extends ConsumerWidget {
  const MainBottomBar({
    super.key,
    required this.currentIndex,
  });
  final int currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      unselectedItemColor: Theme.of(context).colorScheme.primary,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      currentIndex: currentIndex,
      onTap: (value) async {
        if (value != currentIndex) {
          final routes = [
            '/calendar',
            '/',
            '/user_list',
          ];
          final router = await ref.read(appRouterProvider.future);

          router.go(routes[value]);
        }
      },
      items: const [
        BottomNavigationBarItem(
          label: "Calendario",
          icon: Icon(Icons.calendar_month),
        ),
        BottomNavigationBarItem(
          label: "Inicio",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: "Listado Usuarios",
          icon: Icon(Icons.people),
        ),
      ],
    );
  }
}
