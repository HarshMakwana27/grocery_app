import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kColorScheme = ColorScheme(
  primary: Colors.lightGreen,
  onPrimary: Color.fromARGB(255, 255, 255, 255),
  secondary: Color.fromRGBO(90, 93, 187, 1),
  tertiary: Color.fromARGB(255, 37, 249, 26),
  brightness: Brightness.light,
  onSecondary: Color.fromARGB(255, 0, 0, 0),
  error: Colors.red,
  onError: Colors.black,
  onBackground: Color.fromARGB(255, 0, 0, 0),
  onSurface: Color.fromARGB(255, 0, 0, 0),
  background: Color.fromARGB(255, 255, 255, 255),
  surface: Color.fromARGB(255, 255, 255, 255),
);

final kDarkColorScheme = ColorScheme(
  primary: const Color.fromRGBO(48, 63, 159, 1),
  onPrimary: const Color.fromARGB(255, 255, 255, 255),
  secondary: Colors.grey.shade400,
  tertiary: Colors.green.shade400,
  brightness: Brightness.light,
  onSecondary: Colors.black,
  error: Colors.red.shade800,
  onError: Colors.black,
  onBackground: Colors.white,
  onSurface: Colors.white,
  background: Colors.black,
  surface: Colors.black,
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: kColorScheme,
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    titleMedium: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
  ),
);

final darkTheme = ThemeData().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: kDarkColorScheme,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      titleMedium: const TextStyle(color: Colors.white),
    ),
    appBarTheme: AppBarTheme(backgroundColor: kDarkColorScheme.primary));
