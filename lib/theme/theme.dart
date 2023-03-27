import 'package:flutter/material.dart';

class Themes {
  static ThemeData customDarkTheme = ThemeData.dark().copyWith(
      primaryColor: Colors.black,
      canvasColor: Colors.transparent,
      primaryIconTheme: const IconThemeData(color: Colors.black),
      textTheme: const TextTheme(
          headlineSmall: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 24),
          bodyMedium: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18),
          bodyLarge: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16),
          bodySmall: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.normal,
              color: Colors.white,
              fontSize: 14)),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white));

  static ThemeData customPurpleTheme = ThemeData.dark().copyWith(
    primaryColor: const Color(0xff242248),
    canvasColor: Colors.transparent,
    primaryIconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 24),
      bodyMedium: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18),
      bodyLarge: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16),
      bodySmall: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontSize: 14),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: const Color(0xff8468DD))
        .copyWith(secondary: const Color(0xff8468DD)),
        
  );
  static ThemeData customLightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.white,
    canvasColor: Colors.transparent,
    primaryIconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 24),
      bodyMedium: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 18),
      bodyLarge: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 16),
      bodySmall: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontSize: 14),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Colors.white)
        .copyWith(secondary: const Color(0xff8468DD)),
  );
}
