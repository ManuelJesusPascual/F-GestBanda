import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestbanda/config/router/routes_config.dart';

class MainBottomBar extends StatelessWidget {
  const MainBottomBar({
    super.key,
    required this.currentIndex,
  });
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      unselectedItemColor: Theme.of(context).colorScheme.surface,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      onTap: (value) {
        if (value != currentIndex) {
          final routes = [
            '/calendar',
            '/',
            '/user_list',
          ];
          context.read<RouterSimpleCubit>().go(routes[value]);
        }
      },
      items: const [
        BottomNavigationBarItem(
          label: "Calendar",
          icon: Icon(Icons.calendar_month),
        ),
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(Icons.people),
        ),
      ],
    );
  }
}
