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

class HomePage extends StatefulWidget {
  final String steamID;
  final List<GameModel> allGames;
  final Map<String, List<GameModel>> explorePageData;
  //SettingsDrawer settingsDrawer;

  const HomePage(
      {Key? key,
      required this.steamID,
      required this.allGames,
      required this.explorePageData})
      : super(key: key);

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
      HomeWidget(
        allGames: widget.allGames,
      ),
      Explore(explorePageData: widget.explorePageData),
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
                    Icons.videogame_asset,
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
              future: FireStore.getPlayerSummary(),
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
