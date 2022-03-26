import 'package:flutter/material.dart';

class Themes {
  /*--------------- Light Mode ---------------*/
  final lightMode = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: const Color(0xffFEDA00),
    indicatorColor: Colors.white,
    toggleableActiveColor: const Color(0xFFF9F1A3),
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: const Color(0xFFd63031),
    buttonTheme: ButtonThemeData(
        colorScheme: const ColorScheme.light().copyWith(
          primary: const Color(0xffFEDA00),
          secondary: const Color(0xFFF9F1A3),
        ),
        textTheme: ButtonTextTheme.primary,
        splashColor: Colors.grey,
        buttonColor: const Color(0xffFEDA00)),
    textTheme: const TextTheme(
      headline4: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ), colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xffFEDA00),
      secondary: const Color(0xFFF9F1A3),
    ).copyWith(secondary: Colors.grey.shade200),
  );
  /*--------------- Dark Mode ---------------*/
  final darkMode = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: const Color(0xffFEDA00),
    indicatorColor: Colors.white,
    toggleableActiveColor: const Color(0xFFF9F1A3),
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    canvasColor: const Color(0xFF1E272E),
    scaffoldBackgroundColor: const Color(0xFF1E272E),
    backgroundColor: const Color(0xFF1E272E),
    errorColor: const Color(0xFFd63031),
    buttonTheme: ButtonThemeData(
        colorScheme: const ColorScheme.light().copyWith(
          primary: const Color(0xffFEDA00),
          secondary: const Color(0xFFF9F1A3),
        ),
        textTheme: ButtonTextTheme.primary,
        splashColor: Colors.grey,
        buttonColor: const Color(0xffFEDA00)),
    textTheme: const TextTheme(
      headline4: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ), colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xffFEDA00),
      secondary: const Color(0xFFF9F1A3),
      onPrimary: Colors.black,
      onSurface: Colors.white,
      surface: const Color(0xff222F3E),
    ).copyWith(secondary: const Color(0xff222F3E)),
  );
}
