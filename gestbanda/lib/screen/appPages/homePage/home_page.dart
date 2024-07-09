import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      style: Theme.of(context).textTheme.titleLarge,
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
                )
              ],
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  text: "Instrumentos",
                  color: "primary",
                  imgSvgAsset: "assets/svg/instruments_page.svg",
                  imgHeight: 100,
                  imgWidth: 100,
                  onPressed: () {
                    // Implementar la navegación a la página de instrumentos
                  },
                  br: BorderRadius.circular(10),
                  width: 150,
                  height: 200,
                ),
                CustomButton(
                  text: "Ropa",
                  color: "primary",
                  imgSvgAsset: "assets/svg/clothes_page.svg",
                  imgHeight: 100,
                  imgWidth: 100,
                  onPressed: () {
                    // Implementar la navegación a la página de ropa
                  },
                  br: BorderRadius.circular(10),
                  width: 150,
                  height: 200,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
