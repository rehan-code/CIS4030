import 'package:steam_login/steam_login.dart';

class PlayerSummary {
  String steamID;
  String key = "6B0AFC5AE812065E96DEBD875C22017E";

  PlayerSummary(this.steamID);

  Map<String, String> convertSummaries(Map<String, dynamic> summaries) {
    Map<String, String> result = {};

    summaries.forEach((key, value) {
      result[key] = value.toString();
    });

    return result;
  }

  void printSummary() async {
    Map<String, dynamic>? summaryMap = await GetPlayerSummaries(steamID, key);

    Map<String, String> convertedSummaries = convertSummaries(summaryMap);

    convertedSummaries.forEach((key, value) {
      print(key + ": " + value);
    });
  }
}
