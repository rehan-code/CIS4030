import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/player_summary.dart';
import 'package:my_games_tracker/services/steamAPI.dart';
import 'package:my_games_tracker/view/widgets/error_text.dart';
import 'package:my_games_tracker/view/widgets/explore.dart';
import 'package:my_games_tracker/view/widgets/settings_drawer.dart';
import 'package:provider/provider.dart';
import '../../core/game_model.dart';
import '../widgets/theme_provider.dart';
import '/view/widgets/home_widget.dart';
import '../../services/firestore.dart';

class Random extends StatefulWidget {
  final String steamID;
  const Random({Key? key, required this.steamID}) : super(key: key);

  @override
  State<Random> createState() => RandomState();
}

class RandomState extends State<Random> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomePage extends StatefulWidget {
  final String steamID;
  //SettingsDrawer settingsDrawer;

  const HomePage({Key? key, required this.steamID}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = [];

  int _selectedIndex = 0;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _onItemTapped(int index) {
    index == 2
        ? _drawerKey.currentState!.openEndDrawer()
        : setState(() {
            _selectedIndex = index;
          });
  }

  @override
  void initState() {
    _widgetOptions.addAll(<Widget>[
      FutureBuilder<List<GameModel>>(
        future: SteamAPI.getPlayerLibrary(widget.steamID),
        builder: (BuildContext context, AsyncSnapshot<List<GameModel>> s) {
          if (!s.hasData) {
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).indicatorColor),
            );
          } else if (s.hasError) {
            return ErrorText("Error: Could not fetch the player's library.",
                FontWeight.normal, 25.0);
          } else {
            print("User Library: " + (s.data!).toString());
            FireStore.updateAllUserGames(widget.steamID, s.data!);
            return HomeWidget(allGames: s.data!);
          }
        },
      ),

      // HomeWidget(),
      Explore(),
      Center(
          child: Text(
        'List Page',
      )),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        title: 'Welcome to Flutter',
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: SafeArea(
          child: Scaffold(
            key: _drawerKey,
            body: _widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 40,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    size: 40,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                    size: 40,
                  ),
                  label: '',
                ),
              ],
            ),
            endDrawer:
                //  SettingsDrawer(FireStore.getPlayerSummary(widget.steamID), themeProvider)
                FutureBuilder<PlayerSummary>(
              future: FireStore.getPlayerSummary(widget.steamID),
              builder: (BuildContext context, AsyncSnapshot<PlayerSummary> s) {
                if (!s.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).indicatorColor),
                  );
                } else if (s.hasError) {
                  return ErrorText("Error: Could not fetch data for drawer.",
                      FontWeight.normal, 25.0);
                } else {
                  return SettingsDrawer(s.data!, themeProvider);

                  // if (settingsDrawer != null) {
                  //   return settingsDrawer;
                  // } else {
                  //   return ErrorText(
                  //       "Error: A response from server received, but was null.",
                  //       FontWeight.normal,
                  //       25.0);
                  // }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
