import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var theme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      surface: Color(0xFFFFFFFF),
      primary: Color(0xFFA1824A),
      secondary: Color(0xFF1C170D),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFA1824A),
      onSurface: Color(0xFF1C170D),
      error: Color(0xFFB00020),
      onError: Color(0xFFFFFFFF)),
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
  colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      surface: Color(0xFF1A1A1A),
      primary: Color(0xFFB09C6C),
      secondary: Color(0xFFFFFFFF),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFB09C6C),
      onSurface: Color(0xFFFFFFFF),
      error: Color(0xFFB00020),
      onError: Color(0xFFFFFFFF)),
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
