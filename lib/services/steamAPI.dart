import 'package:steam_login/steam_login.dart';

class SteamAPI {
  static final String key = "6B0AFC5AE812065E96DEBD875C22017E";

  static Future<Map<String, dynamic>> getPlayerSummary(String steamID) async {
    return await GetPlayerSummaries(steamID, key);
  }
}
