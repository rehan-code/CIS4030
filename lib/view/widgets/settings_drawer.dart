import 'package:flutter/material.dart';
import 'package:my_games_tracker/main.dart';
import 'package:my_games_tracker/view/pages/login_page.dart';

import 'settings.dart';

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
            decoration:  BoxDecoration(color: Theme.of(context).indicatorColor), //
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (imageURL == "")
                    ? Icon(Icons.account_circle, size: 80) // color: Theme.of(context).primaryColor
                    : CircleAvatar(
                        backgroundImage: NetworkImage(imageURL),
                        radius: 50,
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                      child: Text(
                    (accountName == "") ? "User Name" : accountName,
                    style: TextStyle(
                      // color: Colors.white,
                      // color: Theme.of(context).primaryColor,
                      fontSize: 20,
                    ),
                  )),
                ),
              ],
            ),
          ),
          ListTile(
            leading:
                Icon(Icons.logout, size: 20, color: Theme.of(context).indicatorColor), //color: Theme.of(context).iconTheme.color
            title: const Text("Logout"),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
          ListTile(
            leading:
                Icon(Icons.settings, size: 20, color: Theme.of(context).indicatorColor), //color: Theme.of(context).iconTheme.color
            title: const Text("Settings"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings()));
            },
          ),
        ],
      ),
    );
  }
}
