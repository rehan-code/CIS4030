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

  static Future<Map<String, List<GameModel>>> getExplorePageData() async {
    Map<String, String> requestHeaders = {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.60 Safari/537.36',
      'sec-ch-ua-platform': "Windows",
    };
    String url = "http://store.steampowered.com/api/featuredcategories/";
    print(url);
    try {
      http.Response response =
          await http.get(Uri.parse(url), headers: requestHeaders);
      final Map<String, dynamic> parsedResponse = jsonDecode(response.body);

      List<dynamic> specialsResponse =
          parsedResponse['specials']['items'] as List<dynamic>;
      List<GameModel> specials = [];
      for (int i = 0; i < specialsResponse.length; i++) {
        specials.add(GameModel.fromSteamFeatureAPI(
            specialsResponse[i] as Map<String, dynamic>));
      }
      List<dynamic> comingSoonResponse =
          parsedResponse['coming_soon']['items'] as List<dynamic>;
      List<GameModel> comingSoon = [];
      for (int i = 0; i < comingSoonResponse.length; i++) {
        comingSoon.add(GameModel.fromSteamFeatureAPI(
            comingSoonResponse[i] as Map<String, dynamic>));
      }
      List<dynamic> topSellersResponse =
          parsedResponse['top_sellers']['items'] as List<dynamic>;
      List<GameModel> topSellers = [];
      for (int i = 0; i < topSellersResponse.length; i++) {
        topSellers.add(GameModel.fromSteamFeatureAPI(
            topSellersResponse[i] as Map<String, dynamic>));
      }
      List<dynamic> newReleasesResponse =
          parsedResponse['new_releases']['items'] as List<dynamic>;
      List<GameModel> newReleases = [];
      for (int i = 0; i < newReleasesResponse.length; i++) {
        newReleases.add(GameModel.fromSteamFeatureAPI(
            newReleasesResponse[i] as Map<String, dynamic>));
      }
      Map<String, List<GameModel>> exploreData = {
        "specials": specials,
        "coming_soon": comingSoon,
        "top_sellers": topSellers,
        "new_releases": newReleases
      };
      return exploreData;
    } catch (e) {
      print(e);
      return {};
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
      Map<String, String> requestHeaders = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.60 Safari/537.36',
        'Cookie': 'steamCountry=CA%7C247716b8ac01de87a2d15aa982530d60;',
        'DNT': '1',
        'Host': 'store.steampowered.com',
        'Referer': "https://store.steampowered.com/",
        'sec-ch-ua':
            '"Not A;Brand";v="99", "Chromium";v="100", "Google Chrome";v="100"',
        'sec-ch-ua-mobile': '?0',
        'sec-ch-ua-platform': "Windows",
        'Sec-Fetch-Dest': 'document',
        'Sec-Fetch-Mode': 'navigate',
        'Sec-Fetch-Site': 'same-origin',
        'Sec-Fetch-User': '?1',
        'Upgrade-Insecure-Requests': '1',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept-Language': 'en-US,en;q=0.9',
        'Cache-Control': 'max-age=0',
        'Connection': 'keep-alive'
      };
      http.Response response =
          await http.get(Uri.parse(url), headers: requestHeaders);
      final Map<String, dynamic> parsedResponse = jsonDecode(response.body);
      http.Response ratingResponse = await http.get(Uri.parse(ratingURL));
      final Map<String, dynamic> parsedRatingResponse =
          jsonDecode(ratingResponse.body);
      Map<String, dynamic> data = parsedResponse[appID]["data"];
      data.addAll(parsedRatingResponse["query_summary"]);
      return GameModel.fromSteamDetailsAPI(data, existingGame);
    } catch (e) {
      print(e);
      return GameModel(
          "", "", "", "", "", "", "", "", "", [], [], "", false, false, false);
    }
  }

  static Future<List<Map<String, String>>> getSearchData() async {
    String url = "https://api.steampowered.com/ISteamApps/GetAppList/v2/";
    try {
      http.Response response =
            await http.get(Uri.parse(url));
      final Map<String, dynamic> parsedResponse = jsonDecode(response.body);
      List<dynamic> appList = parsedResponse['applist']['apps'];
      List<Map<String,String>> returnList = [];
      for (var app in appList) {
        if (app['name'].isEmpty) continue;
        // print(app["name"]);
        returnList.add({"name": app["name"], "appid": (app["appid"] as int).toString()});
      }
      return returnList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<GameModel>> getGameModelsFromList(List<String> appList) async {
    List<GameModel> returnList = [];
    for (var app in appList) {
      GameModel gameModel = await getAppDetails(app, GameModel(
          "", "", "", "", "", "", "", "", "", [], [], "", false, false, false));
      returnList.add(gameModel);
    }

    return returnList;
  }

  static Future<List<GameModel>> getSearchStuff(String searchKey) async {
    String url = "https://store.steampowered.com/search/suggest?term=$searchKey&f=games&cc=CA";
    Map<String, String> requestHeaders = {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.60 Safari/537.36',
      'Cookie': 'steamCountry=CA%7C247716b8ac01de87a2d15aa982530d60;',
      'DNT': '1',
      'Host': 'store.steampowered.com',
      'Referer': "https://store.steampowered.com/",
      'sec-ch-ua':
          '"Not A;Brand";v="99", "Chromium";v="100", "Google Chrome";v="100"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': "Windows",
      'Sec-Fetch-Dest': 'document',
      'Sec-Fetch-Mode': 'navigate',
      'Sec-Fetch-Site': 'same-origin',
      'Sec-Fetch-User': '?1',
      'Upgrade-Insecure-Requests': '1',
      'Accept-Encoding': 'gzip, deflate, br',
      'Accept-Language': 'en-US,en;q=0.9',
      'Cache-Control': 'max-age=0',
      'Connection': 'keep-alive'
    };
    http.Response response =
        await http.get(Uri.parse(url), headers: requestHeaders);
    List<String> splitBySpace = response.body.split(" ");
    List<String> appList = [];

    for(String s in splitBySpace) {
      List<String> splitByEquals = s.split("=");
      if (splitByEquals.length == 0 || splitByEquals[0] != "data-ds-appid") continue;
      appList.add(splitByEquals[1].replaceAll("\"", ""));
    }
    List<GameModel> endGame = await getGameModelsFromList(appList);
    endGame.removeWhere((element) => element.appid.isEmpty);
    return endGame;
  }
}
