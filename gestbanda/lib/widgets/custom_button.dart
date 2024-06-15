import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.color,
      this.icon,
      this.br,
      this.height,
      this.width,
      this.imgSvgAsset,
      this.imgSemanticLabel,
      this.imgHeight,
      this.imgWidth,
      required this.onPressed});

  final String text;
  final String color;
  final IconData? icon;
  final BorderRadius? br;
  final double? height;
  final double? width;
  final String? imgSvgAsset;
  final String? imgSemanticLabel;
  final double? imgHeight;
  final double? imgWidth;
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
        fixedSize: Size(width ?? 140, height ?? 70),
        shape: RoundedRectangleBorder(
          borderRadius: br != null ? br! : BorderRadius.circular(0),
        ),
      ),
      onPressed: onPressed,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (imgSvgAsset != null)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              imgSvgAsset ?? '',
              width: imgWidth ?? 150,
              height: imgHeight ?? 150,
              semanticsLabel: imgSemanticLabel ?? '',
            ).animate().fade(duration: 800.ms).scale(),
          ),
        if (icon != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.exo(fontSize: 18).fontFamily,
                  color: color == "primary"
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              Icon(
                icon,
                size: 40,
                color: color == "primary"
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSecondary,
              ),
            ],
          ),
        if (icon == null)
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.exo(fontSize: 18).fontFamily,
              color: color == "primary"
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSecondary,
            ),
          ),
      ]),
    );
  }
}
