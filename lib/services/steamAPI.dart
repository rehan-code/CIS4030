import 'dart:convert';
import 'package:html/parser.dart';

import 'package:steam_login/steam_login.dart';
import 'package:http/http.dart' as http;

import '../core/game_model.dart';

class SteamAPI {
  static const String key = "6B0AFC5AE812065E96DEBD875C22017E";

  static Future<Map<String, dynamic>> getPlayerSummary(String steamID) async {
    return await GetPlayerSummaries(steamID, key);
  }

  static Future<List<GameModel>> getPlayerLibrary(String steamID) async {
    String url =
        "https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=" +
            key +
            "&steamid=" +
            steamID +
            "&format=json&include_appinfo=1&include_played_free_games=1";

    try {
      print(url);
      http.Response response = await http.get(Uri.parse(url));
      final parsedResponse = jsonDecode(response.body);

      List<GameModel> gameLibrary = [];
      for (var item in parsedResponse['response']['games']) {
        gameLibrary.add(GameModel.fromSteamLibraryAPI(item));
      }

      return gameLibrary;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<GameModel> getAppDetails(
      String appID, GameModel existingGame) async {
    String url =
        "https://store.steampowered.com/api/appdetails?appids=" + appID;
    String ratingURL =
        "https://store.steampowered.com/appreviews/" + appID + "?json=1";

    print(url);
    try {
      http.Response response = await http.get(Uri.parse(url));
      final Map<String, dynamic> parsedResponse = jsonDecode(response.body);
      http.Response ratingResponse = await http.get(Uri.parse(ratingURL));
      final Map<String, dynamic> parsedRatingResponse =
          jsonDecode(ratingResponse.body);
      Map<String, dynamic> data = parsedResponse[appID]["data"];
      data.addAll(parsedRatingResponse["query_summary"]);
      print("All details data: " + data.toString());
      return GameModel.fromSteamDetailsAPI(data, existingGame);
    } catch (e) {
      print(e);
      return null as GameModel;
    }
  }
}
