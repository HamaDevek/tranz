import 'package:flutter/material.dart';

class Themes {
  /*--------------- Light Mode ---------------*/
  final lightMode = ThemeData.light().copyWith(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.dark,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Color(0xffFEEC46),
      secondary: Color(0xFFF9F1A3),
    ),
    primaryColor: Color(0xffFEEC46),
    buttonColor: Color(0xffFEEC46),
    indicatorColor: Colors.white,
    toggleableActiveColor: Color(0xFFF9F1A3),
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    accentColor: Colors.grey.shade200,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: const Color(0xFFd63031),
    buttonTheme: ButtonThemeData(
        colorScheme: const ColorScheme.light().copyWith(
          primary: Color(0xffFEEC46),
          secondary: Color(0xFFF9F1A3),
        ),
        textTheme: ButtonTextTheme.primary,
        splashColor: Colors.grey,
        buttonColor: Color(0xffFEEC46)),
    textTheme: TextTheme(
      headline4: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  /*--------------- Dark Mode ---------------*/
  final darkMode = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Color(0xffFEEC46),
      secondary: Color(0xFFF9F1A3),
    ),
    primaryColor: Color(0xffFEEC46),
    buttonColor: Color(0xffFEEC46),
    indicatorColor: Colors.white,
    toggleableActiveColor: Color(0xFFF9F1A3),
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    accentColor: Color(0xff222F3E),
    canvasColor: Color(0xFF1E272E),
    scaffoldBackgroundColor: Color(0xFF1E272E),
    backgroundColor: Color(0xFF1E272E),
    errorColor: const Color(0xFFd63031),
    buttonTheme: ButtonThemeData(
        colorScheme: const ColorScheme.light().copyWith(
          primary: Color(0xffFEEC46),
          secondary: Color(0xFFF9F1A3),
        ),
        textTheme: ButtonTextTheme.primary,
        splashColor: Colors.grey,
        buttonColor: Color(0xffFEEC46)),
    textTheme: TextTheme(
      headline4: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
