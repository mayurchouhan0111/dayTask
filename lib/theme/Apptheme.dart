

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  
  static const Color lightPrimary = Color(0xFFFFC107);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Colors.white;
  static const Color lightError = Color(0xFFB00020);
  static const Color lightOnPrimary = Colors.black;
  static const Color lightOnBackground = Color(0xFF121212);
  static const Color lightOnSurface = Color(0xFF121212);

  
  static const Color darkPrimary = Color(0xFFFFC107);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1F1F1F);
  static const Color darkError = Color(0xFFCF6679);
  static const Color darkOnPrimary = Colors.black;
  static const Color darkOnBackground = Colors.white;
  static const Color darkOnSurface = Colors.white;

  
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: lightPrimary,
    colorScheme: const ColorScheme.light(
      primary: lightPrimary,
      background: lightBackground,
      surface: lightSurface,
      error: lightError,
      onPrimary: lightOnPrimary,
      onBackground: lightOnBackground,
      onSurface: lightOnSurface,
    ),
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: lightBackground,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.spaceGrotesk(
        color: lightOnBackground,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: lightOnBackground),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(color: lightOnBackground),
      displayMedium: GoogleFonts.spaceGrotesk(color: lightOnBackground),
      displaySmall: GoogleFonts.spaceGrotesk(color: lightOnBackground),
      headlineLarge: GoogleFonts.spaceGrotesk(color: lightOnBackground),
      headlineMedium: GoogleFonts.spaceGrotesk(color: lightOnBackground),
      headlineSmall: GoogleFonts.spaceGrotesk(color: lightOnBackground),
      titleLarge: GoogleFonts.spaceGrotesk(color: lightOnBackground),
      titleMedium: GoogleFonts.spaceGrotesk(color: lightOnBackground),
      titleSmall: GoogleFonts.spaceGrotesk(color: lightOnBackground),
      bodyLarge: GoogleFonts.spaceGrotesk(color: lightOnBackground),
      bodyMedium: GoogleFonts.spaceGrotesk(color: lightOnBackground),
      bodySmall: GoogleFonts.spaceGrotesk(color: lightOnBackground),
      labelLarge: GoogleFonts.spaceGrotesk(color: lightOnBackground),
      labelMedium: GoogleFonts.spaceGrotesk(color: lightOnBackground),
      labelSmall: GoogleFonts.spaceGrotesk(color: lightOnBackground),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: lightPrimary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightPrimary,
        foregroundColor: lightOnPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: GoogleFonts.spaceGrotesk(color: lightOnSurface.withOpacity(0.5)),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) return lightPrimary;
        return Colors.grey;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );

  
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: darkPrimary,
    colorScheme: const ColorScheme.dark(
      primary: darkPrimary,
      background: darkBackground,
      surface: darkSurface,
      error: darkError,
      onPrimary: darkOnPrimary,
      onBackground: darkOnBackground,
      onSurface: darkOnSurface,
    ),
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackground,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.spaceGrotesk(
        color: darkOnBackground,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: darkOnBackground),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(color: darkOnBackground),
      displayMedium: GoogleFonts.spaceGrotesk(color: darkOnBackground),
      displaySmall: GoogleFonts.spaceGrotesk(color: darkOnBackground),
      headlineLarge: GoogleFonts.spaceGrotesk(color: darkOnBackground),
      headlineMedium: GoogleFonts.spaceGrotesk(color: darkOnBackground),
      headlineSmall: GoogleFonts.spaceGrotesk(color: darkOnBackground),
      titleLarge: GoogleFonts.spaceGrotesk(color: darkOnBackground),
      titleMedium: GoogleFonts.spaceGrotesk(color: darkOnBackground),
      titleSmall: GoogleFonts.spaceGrotesk(color: darkOnBackground),
      bodyLarge: GoogleFonts.spaceGrotesk(color: darkOnBackground),
      bodyMedium: GoogleFonts.spaceGrotesk(color: darkOnBackground),
      bodySmall: GoogleFonts.spaceGrotesk(color: darkOnBackground),
      labelLarge: GoogleFonts.spaceGrotesk(color: darkOnBackground),
      labelMedium: GoogleFonts.spaceGrotesk(color: darkOnBackground),
      labelSmall: GoogleFonts.spaceGrotesk(color: darkOnBackground),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: darkPrimary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkPrimary,
        foregroundColor: darkOnPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: GoogleFonts.spaceGrotesk(color: darkOnSurface.withOpacity(0.5)),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) return darkPrimary;
        return Colors.grey;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );
}