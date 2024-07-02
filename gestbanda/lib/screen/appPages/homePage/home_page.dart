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
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 25),
                child: Row(
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
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    "Tus Instrumentos:",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Instrument(
                      imagePath: "assets/trompeta.png",
                      instrumentName: "Trompeta Do/Sib",
                      quantity: "5",
                    ),
                    Instrument(
                      imagePath: "assets/corneta.png",
                      instrumentName: "Corneta Do/Reb",
                      quantity: "2",
                    ),
                    Instrument(
                      imagePath: "assets/trombon.png",
                      instrumentName: "Trombon Sib/Do",
                      quantity: "3",
                    )
                  ],
                )
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, top: 15),
                  child: Text(
                    "Tu Ropa:",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Instrument(
                      imagePath: "assets/camisa.png",
                      instrumentName: "Camisa",
                      quantity: "2",
                    ),
                    Instrument(
                      imagePath: "assets/corbata.png",
                      instrumentName: "Corbata",
                      quantity: "1",
                    ),
                    Instrument(
                      imagePath: "assets/pantalon.png",
                      instrumentName: "Pantalon",
                      quantity: "3",
                    )
                  ],
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
