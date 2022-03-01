import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('Home Page',)),
    Center(child: Text('Schedule Page',)),
    Center(child: Text('List Page',)),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: const TabBar(
              labelPadding: EdgeInsets.zero,
              tabs: [
                Tab(icon: Text("All", style: TextStyle(fontSize: 12),),),
                Tab(icon: Text("PLAYING", style: TextStyle(fontSize: 12),),),
                Tab(icon: Text("COMPLETED", style: TextStyle(fontSize: 12),),),
                Tab(icon: Text("PLAN TO PLAY", style: TextStyle(fontSize: 12),),),
              ],
            ),
          ),
          body: HomePage._widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.blue,
            unselectedItemColor: Colors.black,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 50,),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 50,),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu, size: 50,),
                label: '',
              ),
            ],
          ),
        ),
      ),      
    );
  }
}