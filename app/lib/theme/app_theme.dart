import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    final textTheme = GoogleFonts.spaceGroteskTextTheme(base.textTheme);

    return base.copyWith(
      textTheme: textTheme,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF0F766E),
        secondary: Color(0xFFF59E0B),
        surface: Color(0xFFF8FAFC),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
      ),
      scaffoldBackgroundColor: const Color(0xFFF3F4F6),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF8FAFC),
        foregroundColor: Color(0xFF0F172A),
        elevation: 0,
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme = GoogleFonts.spaceGroteskTextTheme(base.textTheme);

    return base.copyWith(
      textTheme: textTheme,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF14B8A6),
        secondary: Color(0xFFFBBF24),
        surface: Color(0xFF0F172A),
        onPrimary: Colors.black,
        onSecondary: Colors.black,
      ),
      scaffoldBackgroundColor: const Color(0xFF0B1120),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0F172A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
