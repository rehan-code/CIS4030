import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      // textTheme: GoogleFonts.ubuntuTextTheme(),
      scaffoldBackgroundColor: Colors.grey.shade900,
      primaryColor: Colors.black,
      colorScheme: const ColorScheme.dark(secondary: Colors.deepPurple),
      indicatorColor: Colors.deepPurple,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(1, 33, 33, 33),
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.white),
      errorColor: Colors.red,
      secondaryHeaderColor: Colors.white);

  static final lightTheme = ThemeData(
    // textTheme: GoogleFonts.ubuntuTextTheme(),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(secondary: Colors.deepPurple),
    indicatorColor: Colors.deepPurple,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.deepPurple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black),
    errorColor: Colors.red,
    secondaryHeaderColor: Colors.white,
    cardTheme: const CardTheme(color: Color.fromARGB(255, 240, 240, 240)),
  );
}
