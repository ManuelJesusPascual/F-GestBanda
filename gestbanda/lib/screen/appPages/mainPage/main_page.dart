import 'package:flutter/material.dart';
import 'package:gestbanda/screen/appPages/calendarPage/calendar_page.dart';
import 'package:gestbanda/screen/pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const CalendarPage(),
      const HomePage(),
      const InitialPage()
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/logoBanda.png"),
                    backgroundColor: Colors.transparent,
                    radius: 30,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child: Text(
                        "Banda Municipal de Villaejemplo",
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    color: Theme.of(context).colorScheme.onSurface,
                    onPressed: () {
                      // Implementar la navegación a la pantalla de configuración
                    },
                  ),
                ],
              ),
              const SizedBox(height: 70),
              Expanded(
                child: IndexedStack(
                  index: selectedIndex,
                  children: screens,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
