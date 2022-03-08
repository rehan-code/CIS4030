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
    colorScheme: ColorScheme.dark(),
    // iconTheme: IconThemeData(color: Colors.deepPurple),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.black, selectedItemColor: Colors.deepPurple, unselectedItemColor: Colors.white),
    // listTileTheme: ListTileThemeData(iconColor: Colors.white),
    // tabBarTheme: TabBarTheme(labelColor: Colors.deepPurple, ),
    errorColor: Colors.red,
    // secondaryHeaderColor: Colors.white,
    
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    // iconTheme: IconThemeData(color: Colors.deepPurple, opacity: 0.8), 
    // colorScheme: ColorScheme.light(),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.deepPurple, selectedItemColor: Colors.white, unselectedItemColor: Colors.black),
    // // tabBarTheme: TabBarTheme(labelColor: Colors.black, indicator: BoxDecoration(color: Colors.deepPurple)),
    //  listTileTheme: ListTileThemeData(iconColor: Colors.deepPurple),
    // tabBarTheme: TabBarTheme(labelColor: Colors.deepPurple, unselectedLabelColor: Colors.amber),
    errorColor: Colors.red,
    // secondaryHeaderColor: Colors.white,
    // cardTheme: CardTheme(color: Colors.grey),
    // appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple),
  );
}