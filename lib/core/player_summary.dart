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

    communityVisibility = stringData['communityvisibilitystate'] as String;
    profileState = stringData['profilestate'] as String;
    personaName = stringData['personaname'] as String;
    profileURL = stringData['profileurl'] as String;
    avatar = stringData['avatar'] as String;
    avatarMedium = stringData['avatarmedium'] as String;
    avatarFull = stringData['avatarfull'] as String;
    avatarHash = stringData['avatarhash'] as String;
    lastLogoff = stringData['lastlogoff'] as String;
    personaState = stringData['personastate'] as String;
    realName = stringData['realname'] as String;
    primaryClanID = stringData['primaryclanid'] as String;
    timeCreated = stringData['timecreated'] as String;
    personaStateFlags = stringData['personastateflags'] as String;
    countryCode = stringData['loccountrycode'] as String;
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
