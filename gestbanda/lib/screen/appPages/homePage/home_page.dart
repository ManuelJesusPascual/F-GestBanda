import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  //TODO: Cambiar a BLOC
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
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
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    onPressed: () {},
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Event(
                    date: DateTime(2024, 7, 3),
                    eventName: "Pasacalles",
                  ),
                  Event(
                    date: DateTime(2024, 8, 23),
                    eventName: "Salida Procesional",
                  ),
                  Event(
                    date: DateTime(2024, 9, 14),
                    eventName: "Concierto",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    text: "Instrumentos",
                    color: "primary",
                    imgSvgAsset: "assets/svg/instruments_page.svg",
                    imgHeight: 100,
                    imgWidth: 100,
                    onPressed: () {},
                    br: BorderRadius.circular(10),
                    width: 170,
                    height: 250,
                  ),
                  CustomButton(
                    text: "Ropa",
                    color: "primary",
                    imgSvgAsset: "assets/svg/clothes_page.svg",
                    imgHeight: 100,
                    imgWidth: 100,
                    onPressed: () {},
                    br: BorderRadius.circular(10),
                    width: 170,
                    height: 250,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
