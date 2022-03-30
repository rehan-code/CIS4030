import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/player_summary.dart';
import 'package:my_games_tracker/view/widgets/error_text.dart';
import 'package:my_games_tracker/view/widgets/explore.dart';
import 'package:my_games_tracker/view/widgets/settings_drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/theme_provider.dart';
import '/view/widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  String steamID;
  //SettingsDrawer settingsDrawer;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    Explore(),
    Center(
        child: Text(
      'List Page',
    )),
  ];

  HomePage(this.steamID);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _onItemTapped(int index) {
    index == 2
        ? _drawerKey.currentState!.openEndDrawer()
        : setState(() {
            _selectedIndex = index;
          });
  }

  Future<SettingsDrawer> loadDrawerData(
      PlayerSummary ps, ThemeProvider theme) async {
    await Future.delayed(Duration(seconds: 1), () => ps.buildPlayerSummary());
    return SettingsDrawer(ps.personaName, ps.avatarFull, theme);
  }

  @override
  Widget build(BuildContext context) {
    PlayerSummary summary = PlayerSummary(widget.steamID);
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
            body: HomePage._widgetOptions.elementAt(_selectedIndex),
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
            endDrawer: FutureBuilder(
              future: loadDrawerData(summary, themeProvider),
              builder: (BuildContext context, AsyncSnapshot<SettingsDrawer> s) {
                if (!s.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).indicatorColor),
                  );
                } else if (s.hasError) {
                  return ErrorText("Error: Could not fetch data for drawer.",
                      FontWeight.normal, 25.0);
                } else {
                  final settingsDrawer = s.data;

                  if (settingsDrawer != null) {
                    return settingsDrawer;
                  } else {
                    return ErrorText(
                        "Error: A response from server received, but was null.",
                        FontWeight.normal,
                        25.0);
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
