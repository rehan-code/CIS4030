import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:steam_login/steam_login.dart';

class SteamLogin extends StatefulWidget {
  @override
  State<SteamLogin> createState() => _SteamLoginState();
}

class _SteamLoginState extends State<SteamLogin> {
  final _webView = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    _webView.onUrlChanged.listen((String url) async {
      var openId = OpenId.fromUri(Uri.parse(url));
      if (openId.mode == 'id_res') {
        //print("src: " + openId.host.toString() + " dest: " + openId.returnUrl.toString());
        await _webView.close();
        Navigator.of(context).pop(openId.validate());
      }
    });

    Map<String, String> res = <String, String>{};
    var openId =
        OpenId.raw("https://mygamestracker", "https://mygamestracker/", {});

    return WebviewScaffold(
      url: openId.authUrl().toString(),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Steam Login"),
      ),
    );
  }
}
