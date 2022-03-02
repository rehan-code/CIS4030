import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/player_summary.dart';
import 'package:my_games_tracker/view/widgets/explore.dart';
import 'package:my_games_tracker/view/widgets/settings_drawer.dart';
import '/view/widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  String steamID;

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
    index == 2 ? _drawerKey.currentState!.openEndDrawer() : setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: await_only_futures
    PlayerSummary summary = PlayerSummary(widget.steamID);
    summary.printSummary();

    return MaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          key: _drawerKey,
          body: HomePage._widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.deepPurple,
            unselectedItemColor: Colors.black,
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
          endDrawer: SettingsDrawer(),
        ),
      ),
    );
  }
}
