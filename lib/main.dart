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
  final Future<FirebaseApp> _myGamesTrackerDB = Firebase.initializeApp();
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
          home: FutureBuilder(
            future: _myGamesTrackerDB,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("Firebase Error: ${snapshot.error.toString()}");
                return Text("Couldn't load Firebase Database!");
              } else if (snapshot.hasData) {
                print("FIREBASE INTIALIZED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                // FirebaseFirestore f = FirebaseFirestore.instance;

                // CollectionReference users =
                //     FirebaseFirestore.instance.collection('users');

                // FutureBuilder(
                //   future: users.doc('NcmeaiDE31ShNGUFBuq2').get(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasError) {
                //       print("Error getting data...");
                //     } else if (snapshot.connectionState ==
                //         ConnectionState.done) {
                //       Map<String, dynamic> d =
                //           snapshot.data as Map<String, dynamic>;
                //       print("GOT DATA BOIIIIISSSSSSSSS!!!!!!!!");
                //     }
                //     return Container();
                //   },
                // );

                return Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  body: LoginScreen(themeProvider),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }
}
