import 'package:flutter/material.dart';

class AppTheme {
  static const Color primraryLight = Color(0xFF5D9CEC);
  static const Color primrarydark = Color(0xFF060E1E);
  static const Color bgLight = Color(0xFFDFECDB);
  static const Color bgDark = Color(0xFF1E1E1E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color green = Color(0xFF61E757);
  static const Color red = Color(0xFFEC4B4B);
  static const Color grey = Color(0xFFC8C9CB);
  static const Color black = Color(0xFF363636);

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: bgLight,
      primaryColor: primraryLight,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primraryLight,
        unselectedItemColor: grey,
        backgroundColor: white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primraryLight,
        foregroundColor: white,
        shape: CircleBorder(side: BorderSide(width: 4, color: white)),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: black,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primraryLight,
        ),
        labelMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: black,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: primraryLight,
      )));

  static ThemeData DarkTheme = ThemeData(
      scaffoldBackgroundColor: primrarydark,
      primaryColor: primraryLight,
      hintColor: grey,
      dropdownMenuTheme: DropdownMenuThemeData(
          menuStyle: MenuStyle(backgroundColor: WidgetStatePropertyAll(grey))),
      // appBarTheme: AppBarTheme(backgroundColor: black),
      iconTheme: IconThemeData(color: white),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primraryLight,
        unselectedItemColor: grey,
        backgroundColor: black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primraryLight,
        foregroundColor: white,
        shape: CircleBorder(side: BorderSide(width: 4, color: black)),
      ),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: grey), suffixIconColor: white),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: black,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primraryLight,
        ),
        labelMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: white,
        ),
        labelSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: white,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: black,
        ),
        headlineSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: white,
        ),
        bodyLarge: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w400,
          color: white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: primraryLight,
      )));
}
