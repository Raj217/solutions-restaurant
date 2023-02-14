import 'package:flutter/material.dart';
import 'package:solutions/configs/configs.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: darkTertiaryColor,
  fontFamily: 'Montserrat',
  useMaterial3: true,
  canvasColor: darkTertiaryColor,
  appBarTheme: const AppBarTheme(color: darkTertiaryColor),
  scaffoldBackgroundColor: darkTertiaryColor,
  colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primarySwatch, brightness: Brightness.dark)
      .copyWith(secondary: darkSecondaryColor),
);
