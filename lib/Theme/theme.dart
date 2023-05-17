import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.transparent,
  ),
  scaffoldBackgroundColor: const Color(0xff1E272E),
  primaryColorDark: ColorPalette.primary,
  primaryColorLight: ColorPalette.primary,
  primaryColor: ColorPalette.primary,
  colorScheme: ColorScheme.fromSeed(
    seedColor: ColorPalette.primary,
    primary: ColorPalette.yellow,
    // brightness: Brightness.dark,
    secondary: ColorPalette.whiteColor,
  ),
);

class ColorPalette {
  static const Color red = Color(0xffD74D48);
  static const primary = Color(0xff1E272E);
  static const primaryDark = Color(0xff13171A);
  static const primaryLight = Color(0xbc1e272e);
  static const black = Color(0xff181C1F);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color greyText = Color(0xbcffffff);
  static const Color yellow = Color(0xffFEDA00);
  static const Color green = Color(0xffB6E148);
  static const Color brown = Color(0xffD74D48);
  static const Color orange = Color(0xffE7642C);
}
