import 'package:flutter/material.dart';
import '../../../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Leave(
                date: DateTime(2024, 7, 3),
                eventName: "Pasacalles",
              ),
              Leave(
                date: DateTime(2024, 8, 23),
                eventName: "Salida Procesional",
              ),
              Leave(
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
    );
  }
}
