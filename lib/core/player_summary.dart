import 'package:steam_login/steam_login.dart';

class PlayerSummary {
  String key = "6B0AFC5AE812065E96DEBD875C22017E";
  String steamID;
  Map<String, String> stringData = {};
  String communityVisibility = "";
  String profileState = "";
  String personaName = "";
  String profileURL = "";
  String avatar = "";
  String avatarMedium = "";
  String avatarFull = "";
  String avatarHash = "";
  String lastLogoff = "";
  String personaState = "";
  String realName = "";
  String primaryClanID = "";
  String timeCreated = "";
  String personaStateFlags = "";
  String countryCode = "";

  PlayerSummary(this.steamID);

  Future<void> buildPlayerSummary() async {
    Map<String, dynamic> summaryData = await GetPlayerSummaries(steamID, key);

    summaryData.forEach((key, value) {
      stringData[key] = value.toString();
    });

    communityVisibility = (stringData['communityvisibilitystate'] == null
        ? stringData['communityvisibilitystate'].toString()
        : "");
    profileState = (stringData['profilestate'] != null
        ? stringData['profilestate'].toString()
        : "");
    personaName = (stringData['personaname'] != null
        ? stringData['personaname'].toString()
        : "");
    profileURL = (stringData['profileurl'] != null
        ? stringData['profileurl'].toString()
        : "");
    avatar =
        (stringData['avatar'] != null ? stringData['avatar'].toString() : "");
    avatarMedium = (stringData['avatarmedium'] != null
        ? stringData['avatarmedium'].toString()
        : "");
    avatarFull = (stringData['avatarfull'] != null
        ? stringData['avatarfull'].toString()
        : "");
    avatarHash = (stringData['avatarhash'] == null
        ? stringData['avatarhash'].toString()
        : "");
    lastLogoff = (stringData['lastlogoff'] != null
        ? stringData['lastlogoff'].toString()
        : "");
    personaState = (stringData['personastate'] != null
        ? stringData['personastate'].toString()
        : "");
    realName = (stringData['realname'] != null
        ? stringData['realname'].toString()
        : "");
    primaryClanID = (stringData['primaryclanid'] != null
        ? stringData['primaryclanid'].toString()
        : "");
    timeCreated = (stringData['timecreated'] != null
        ? stringData['timecreated'].toString()
        : "");
    personaStateFlags = (stringData['personastateflags'] != null
        ? stringData['personastateflags'].toString()
        : "");
    countryCode = (stringData['loccountrycode'] != null
        ? stringData['loccountrycode'].toString()
        : "");
  }

  void printSummary() {
    print("steamID: " + steamID);
    print("communityVisibility: " + communityVisibility.toString());
    print("profileState: " + profileState.toString());
    print("personaName: " + personaName);
    print("profileURL: " + profileURL);
    print("avatar: " + avatar);
    print("avatarMedium: " + avatarMedium);
    print("avatarFull: " + avatarFull);
    print("avatarHash: " + avatarHash);
    print("lastLogoff: " + lastLogoff.toString());
    print("personaState: " + personaState.toString());
    print("realName: " + realName);
    print("primaryClanID: " + primaryClanID.toString());
    print("timeCreated: " + timeCreated.toString());
    print("personaStateFlags: " + personaStateFlags.toString());
    print("countryCode: " + countryCode.toString());
  }
}
