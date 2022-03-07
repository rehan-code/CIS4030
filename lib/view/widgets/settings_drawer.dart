import 'package:flutter/material.dart';
import 'package:my_games_tracker/main.dart';
import 'package:my_games_tracker/view/pages/login_page.dart';

class SettingsDrawer extends StatelessWidget {
  final String accountName;
  final String imageURL;

  SettingsDrawer(this.accountName, this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.deepPurple),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (imageURL == "")
                    ? const Icon(Icons.account_circle,
                        color: Colors.white, size: 80)
                    : CircleAvatar(
                        backgroundImage: NetworkImage(imageURL),
                        radius: 50,
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                      child: Text(
                    (accountName == "") ? "User Name" : accountName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
                ),
              ],
            ),
          ),
          ListTile(
            leading:
                const Icon(Icons.logout, color: Colors.deepPurple, size: 20),
            title: const Text("Logout"),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.settings, color: Colors.deepPurple, size: 20),
            title: const Text("Settings"),
            onTap: () {
              // TODO: Connect this to the settings functionality / screen.
            },
          ),
        ],
      ),
    );
  }
}
