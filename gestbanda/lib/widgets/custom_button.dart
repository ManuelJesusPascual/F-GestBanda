import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.color,
      this.br,
      required this.onPressed});

  final String text;
  final String color;
  final BorderRadius? br;
  final Function()? onPressed;
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
          borderRadius: br != null ? br! : BorderRadius.circular(0),
        ),
      ),
      onPressed: onPressed,
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
