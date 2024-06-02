import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.cyan, brightness: Brightness.light),
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.exo(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.exo(),
    displaySmall: GoogleFonts.exo(
      fontSize: 18,
    ),
  ),
);

var darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme:
      ColorScheme.fromSeed(seedColor: Colors.cyan, brightness: Brightness.dark),
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.exo(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.exo(),
    displaySmall: GoogleFonts.exo(
      fontSize: 18,
    ),
  ),
);
