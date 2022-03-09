import 'package:flutter/material.dart';
import 'package:my_games_tracker/view/widgets/theme_provider.dart';
import '../pages/steam_webview_login.dart';

class SteamLoginButton extends StatefulWidget {
  ThemeProvider themeProvider;

  SteamLoginButton(this.themeProvider);

  @override
  _SteamLoginButton createState() => _SteamLoginButton();
}

class _SteamLoginButton extends State<SteamLoginButton> {
  String steamID = "NULL";

  idCallback(thisID) {
    steamID = thisID;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          SizedBox(
            width: 150,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SteamLogin()));
              },
              child: Center(
                  child: Text(
                "Login With Steam",
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              )),
            ),
          ),
          // Center(
          //   child: Text("STEAM ID: " + steamID),
          // )
        ],
      ),
    );
  }
}
