import 'package:flutter/material.dart';

class SettingsDrawer extends StatelessWidget{
  const SettingsDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
           DrawerHeader(
            decoration: const BoxDecoration( color: Colors.deepPurple ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon( Icons.account_circle, color: Colors.white, size: 80 ),
                Center( child: Text( "User Name",
                  style:
                    TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                ),
              ],
            ),
          ),
           ListTile(
            leading: const Icon( Icons.logout, color: Colors.deepPurple, size: 20 ),
            title: const Text( "Logout" ),
            onTap: () {
              // TODO: Connect this to the logout functionality / screen.
            },
          ),
          ListTile(
            leading: const Icon( Icons.settings, color: Colors.deepPurple, size: 20 ),
            title: const Text( "Settings" ),
            onTap: () {
              // TODO: Connect this to the settings functionality / screen.
            },
          ),
        ],
      ),
    );
  }
}