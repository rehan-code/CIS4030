import 'package:flutter/material.dart';
import 'package:my_games_tracker/view/widgets/steam_login_button.dart';
import 'package:my_games_tracker/view/widgets/theme_provider.dart';

class LoginScreen extends StatelessWidget {
  ThemeProvider themeProvider;

  LoginScreen(this.themeProvider);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
            child: Image.asset("assets/images/pineapple.png"),
          ),
          const Text(
            "My Game Tracker",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                decorationStyle: TextDecorationStyle.wavy,
                // fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900),
          ),
          SteamLoginButton(themeProvider)
        ],
      ),
    );
  }
}
