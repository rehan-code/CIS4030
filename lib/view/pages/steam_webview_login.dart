import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:my_games_tracker/services/firestore.dart';
import 'package:my_games_tracker/view/pages/login_page.dart';
import 'package:my_games_tracker/view/widgets/theme_provider.dart';
import 'package:steam_login/steam_login.dart';
import '../../core/game_data.dart';
import '../../core/game_model.dart';
import '../../services/firestore.dart';

import '../../services/steamAPI.dart';
import 'home_page.dart';

class SteamLogin extends StatefulWidget {
  @override
  State<SteamLogin> createState() => _SteamLoginState();
}

class _SteamLoginState extends State<SteamLogin> {
  final _webView = FlutterWebviewPlugin();
  ThemeProvider themeProvider = ThemeProvider();
  String steamID = "";

  @override
  Widget build(BuildContext context) {
    _webView.onUrlChanged.listen((String url) async {
      var openId = OpenId.fromUri(Uri.parse(url));
      if (openId.mode == 'id_res') {
        //print("src: " + openId.host.toString() + " dest: " + openId.returnUrl.toString());
        await _webView.close();
        steamID = await openId.validate();
        if (steamID != "") {
          List<GameModel> allGames = await SteamAPI.getPlayerLibrary(steamID);
          Map<String, List<GameModel>> explorePageData =
              await SteamAPI.getExplorePageData();
          await FireStore.addSteamID(steamID);
          await FireStore.updateAllUserGames(allGames);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(
                steamID: steamID,
                allGames: allGames,
                explorePageData: explorePageData),
          ));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginScreen(themeProvider),
          ));
        }
      }
    });

    Map<String, String> res = <String, String>{};
    var openId =
        OpenId.raw("https://mygamestracker", "https://mygamestracker/", {});

    return WebviewScaffold(
      url: openId.authUrl().toString(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).indicatorColor,
        title: const Text("Steam Login"),
      ),
    );
  }
}
