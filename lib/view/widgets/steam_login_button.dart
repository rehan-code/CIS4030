import 'package:flutter/material.dart';
import '../pages/steam_webview_login.dart';

class SteamLoginButton extends StatefulWidget {
  const SteamLoginButton({Key? key}) : super(key: key);

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
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SteamLogin()));
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
