import 'package:flutter/material.dart';
import 'package:solutions/configs/configs.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightTertiaryColor,
  fontFamily: 'Montserrat',
  useMaterial3: true,
  canvasColor: lightTertiaryColor,
  scaffoldBackgroundColor: lightTertiaryColor,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: primarySwatch,
  ).copyWith(secondary: lightSecondaryColor),
);
