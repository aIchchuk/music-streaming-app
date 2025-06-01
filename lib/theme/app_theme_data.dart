// theme_data.dart
import 'package:flutter/material.dart';

ThemeData appThemeData = ThemeData(
  primaryColor: Colors.deepOrange,
  fontFamily: 'HelveticaNeueLight',
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.deepOrange,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.redAccent, // For accent color
  ),
);
