import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2E7D32),
      brightness: Brightness.light,
      surface: const Color(0xFFFFFFFF),
      primary: const Color(0xFF2E7D32),
      secondary: const Color(0xFFC5E1A5),
      onPrimary: const Color(0xFFFFFFFF),
      onSecondary: const Color(0xFFFFFFFF),
      onSurface: const Color(0xFF000000)),
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
      seedColor: const Color(0xFF2E7D32),
      brightness: Brightness.dark,
      surface: const Color(0xFF121212),
      primary: const Color(0xFF81C784),
      secondary: const Color(0xFFC5E1A5),
      onPrimary: const Color(0xFF121212),
      onSecondary: const Color(0xFFFFFFFF),
      onSurface: const Color(0xFFFFFFFF)),
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
