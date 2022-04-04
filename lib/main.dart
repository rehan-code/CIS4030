import 'package:flutter/material.dart';
import 'package:my_games_tracker/view/pages/login_page.dart';
import 'package:my_games_tracker/view/widgets/theme_provider.dart';
import 'package:provider/provider.dart';
import '/view/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  ThemeProvider themeProvider = ThemeProvider();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(themeProvider));
}

class MyApp extends StatelessWidget {
  ThemeProvider themeProvider;
  MyApp(this.themeProvider);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => themeProvider,
      builder: (context, _) {
        themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: LoginScreen(themeProvider),
          ),
        );
      },
    );
  }
}
