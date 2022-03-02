import 'package:flutter/material.dart';
import 'package:my_games_tracker/view/pages/home_page.dart';
import 'package:steam_login/steam_login.dart';

import 'dart:io';

import '../../core/player_summary.dart';
import '../pages/steam_webview_login.dart';

class SteamLoginButton extends StatefulWidget {
  String skey = "6B0AFC5AE812065E96DEBD875C22017E";
  final String outputFile = "lib/data/playerSummary.txt";

  @override
  _SteamLoginButton createState() => _SteamLoginButton();
}

class _SteamLoginButton extends State<SteamLoginButton> {
  String steamID = "NULL";

  idCallback(thisID) {
    steamID = thisID;
  }

  Map<String, String> convertSummaries(Map<String, dynamic> summaries) {
    Map<String, String> result = {};

    summaries.forEach((key, value) {
      result[key] = value.toString();
    });

    return result;
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
              onPressed: () async {
                final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SteamLogin()));

                setState(() {
                  steamID = result;
                });

                Map<String, dynamic>? summaryMap =
                    await GetPlayerSummaries(steamID, widget.skey);

                Map<String, String> convertedSummaries =
                    convertSummaries(summaryMap);

                convertedSummaries.forEach((key, value) {
                  print(key + ": " + value);
                });

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Center(
                  child: Text(
                "Login With Steam",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(17, 17, 17, 1.0))),
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
