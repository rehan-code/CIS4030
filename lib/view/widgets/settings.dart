import 'package:flutter/material.dart';
import 'package:my_games_tracker/view/widgets/theme_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);
  
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
 
  @override
  Widget build(BuildContext context) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return MaterialApp(
              title: 'Welcome to Flutter',
              debugShowCheckedModeBanner: false,
              themeMode: themeProvider.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              home: Scaffold(
                // drawer: PageNavigationWidget(),
                appBar: AppBar(
                  // iconTheme: Theme.of(context).iconTheme,
                  backgroundColor: Theme.of(context).indicatorColor,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    // color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  title: const Text('Settings',),  
                  // backgroundColor: Colors.deepPurple,
                  // backgroundColor: Theme.of(context).primaryColor,        
                ),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.dark_mode, size: 30,),
                          SizedBox(width: 20,),
                          Text("Dark Mode", style: TextStyle(fontSize: 24),),
                          Spacer(),
                          Switch.adaptive(
                            value: themeProvider.isDarkMode, 
                            activeColor: Theme.of(context).indicatorColor,
                            inactiveTrackColor: Theme.of(context).indicatorColor,
                            onChanged: (value) {
                              final provider = Provider.of<ThemeProvider>(context, listen: false);
                              provider.toggleTheme(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ),
            );
          }
}