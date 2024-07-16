import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2E7D32), // Verde oscuro
      brightness: Brightness.light,
      surface: const Color(0xFFFFFFFF), // Fondo de superficie blanco
      primary: const Color(0xFF2E7D32), // Color primario (verde oscuro)
      secondary: const Color(0xFFCDDC39), // Marrón oscuro
      onPrimary: const Color(0xFFFFFFFF), // Texto en color primario (blanco)
      onSecondary:
          const Color(0xFFFFFFFF), // Texto en color secundario (blanco)
      onSurface: const Color(
          0xFF000000)), // Texto en superficies (negro)// Texto en superficies (negro),
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.poppins(),
    displaySmall: GoogleFonts.poppins(
      fontSize: 18,
    ),
  ),
);

var darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2E7D32), // Verde oscuro
      brightness: Brightness.dark,
      surface: const Color(0xFF121212), // Fondo de superficie oscuro
      primary: const Color(0xFF81C784), // Verde claro derivado del verde oscuro
      secondary: const Color(0xFFCDDC39), // Marrón oscuro
      onPrimary: const Color(0xFF121212), // Texto en color primario (oscuro)
      onSecondary:
          const Color(0xFFFFFFFF), // Texto en color secundario (blanco)
      onSurface: const Color(0xFFFFFFFF)), // Texto en superficies (blanco)
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.poppins(),
    displaySmall: GoogleFonts.poppins(
      fontSize: 18,
    ),
  ),
);
