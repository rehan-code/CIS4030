import 'package:flutter/material.dart';

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
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(secondary: Colors.deepPurple),
    indicatorColor: Colors.deepPurple,
    buttonTheme: ButtonThemeData(
        buttonColor: Colors.deepPurple, colorScheme: const ColorScheme.dark()),

    errorColor: Colors.red,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(1, 33, 33, 33),
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.white),
    // listTileTheme: ListTileThemeData(iconColor: Colors.white),
    // tabBarTheme: TabBarTheme(labelColor: Colors.deepPurple, ),
    // iconTheme: IconThemeData(color: Colors.deepPurple),
    // secondaryHeaderColor: Colors.white,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    // iconTheme: IconThemeData(color: Colors.deepPurple, opacity: 0.8),
    colorScheme:
        ColorScheme.light(secondary: Color.fromARGB(255, 33, 168, 155)),
    indicatorColor: Color.fromARGB(255, 33, 168, 155),
    // buttonTheme:
    //     ButtonThemeData(buttonColor: Color.fromARGB(255, 33, 168, 155)),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(255, 33, 168, 155),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black),
    errorColor: Colors.red,
    cardTheme: CardTheme(color: Color.fromARGB(255, 240, 240, 240)),
    // appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple),
    // // tabBarTheme: TabBarTheme(labelColor: Colors.black, indicator: BoxDecoration(color: Colors.deepPurple)),
    //  listTileTheme: ListTileThemeData(iconColor: Colors.deepPurple),
    // tabBarTheme: TabBarTheme(indicator: BoxDecoration(color: Colors.deepPurple)),
    // secondaryHeaderColor: Colors.white,
  );
}
