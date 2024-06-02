import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Gestiona tu banda \n en unos simples pasos!',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Trajes, componentes, instrumentos, salidas \n ¡Y mucho mas!",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: "Iniciar Sesion",
                  color: "primary",
                  br: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                CustomButton(
                  text: "Registrarse",
                  color: "secondary",
                  br: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.text, required this.color, required this.br});

  final String text;
  final String color;
  final BorderRadius br;
  @override
  Widget build(
    BuildContext context,
  ) {
    return ElevatedButton(
      style: TextButton.styleFrom(
        backgroundColor: color == "primary"
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        fixedSize: const Size(140, 70),
        shape: RoundedRectangleBorder(
          borderRadius: br,
        ),
      ),
      onPressed: () => {},
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.exo(fontSize: 18).fontFamily,
          color: color == "primary"
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}
