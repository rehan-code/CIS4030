import 'dart:async';

import 'package:steam_login/steam_login.dart';

class PlayerSummary {
  final String communityvisibilitystate;
  final String profilestate;
  final String personaname;
  final String profileurl;
  final String avatar;
  final String avatarmedium;
  final String avatarfull;
  final String avatarhash;
  final String lastlogoff;
  final String personastate;
  final String realname;
  final String primaryclanid;
  final String timecreated;
  final String personastateflags;
  final String loccountrycode;

  PlayerSummary(
      this.communityvisibilitystate,
      this.profilestate,
      this.personaname,
      this.profileurl,
      this.avatar,
      this.avatarmedium,
      this.avatarfull,
      this.avatarhash,
      this.lastlogoff,
      this.personastate,
      this.realname,
      this.primaryclanid,
      this.timecreated,
      this.personastateflags,
      this.loccountrycode);

  // Future<void> buildPlayerSummary() async {
  //   Map<String, dynamic> summaryData = await GetPlayerSummaries(steamID, key);

  //   // summaryData.forEach((key, value) {
  //   //   stringData[key] = value.toString();
  //   // });

  //   communityVisibility = (stringData['communityvisibilitystate'] == null
  //       ? stringData['communityvisibilitystate'].toString()
  //       : "");
  //   profileState = (stringData['profilestate'] != null
  //       ? stringData['profilestate'].toString()
  //       : "");
  //   personaName = (stringData['personaname'] != null
  //       ? stringData['personaname'].toString()
  //       : "");
  //   profileURL = (stringData['profileurl'] != null
  //       ? stringData['profileurl'].toString()
  //       : "");
  //   avatar =
  //       (stringData['avatar'] != null ? stringData['avatar'].toString() : "");
  //   avatarMedium = (stringData['avatarmedium'] != null
  //       ? stringData['avatarmedium'].toString()
  //       : "");
  //   avatarFull = (stringData['avatarfull'] != null
  //       ? stringData['avatarfull'].toString()
  //       : "");
  //   avatarHash = (stringData['avatarhash'] == null
  //       ? stringData['avatarhash'].toString()
  //       : "");
  //   lastLogoff = (stringData['lastlogoff'] != null
  //       ? stringData['lastlogoff'].toString()
  //       : "");
  //   personaState = (stringData['personastate'] != null
  //       ? stringData['personastate'].toString()
  //       : "");
  //   realName = (stringData['realname'] != null
  //       ? stringData['realname'].toString()
  //       : "");
  //   primaryClanID = (stringData['primaryclanid'] != null
  //       ? stringData['primaryclanid'].toString()
  //       : "");
  //   timeCreated = (stringData['timecreated'] != null
  //       ? stringData['timecreated'].toString()
  //       : "");
  //   personaStateFlags = (stringData['personastateflags'] != null
  //       ? stringData['personastateflags'].toString()
  //       : "");
  //   countryCode = (stringData['loccountrycode'] != null
  //       ? stringData['loccountrycode'].toString()
  //       : "");
  // }

  factory PlayerSummary.fromJSON(Map<String, dynamic> stringData) {
    String communityVisibility = (stringData['communityvisibilitystate'] != null
        ? stringData['communityvisibilitystate'].toString()
        : "");
    String profileState = (stringData['profilestate'] != null
        ? stringData['profilestate'].toString()
        : "");
    String personaName = (stringData['personaname'] != null
        ? stringData['personaname'].toString()
        : "");
    String profileURL = (stringData['profileurl'] != null
        ? stringData['profileurl'] as String
        : "");
    String avatar =
        (stringData['avatar'] != null ? stringData['avatar'].toString() : "");
    String avatarMedium = (stringData['avatarmedium'] != null
        ? stringData['avatarmedium'].toString()
        : "");
    String avatarFull = (stringData['avatarfull'] != null
        ? stringData['avatarfull'].toString()
        : "");
    String avatarHash = (stringData['avatarhash'] != null
        ? stringData['avatarhash'].toString()
        : "");
    String lastLogoff = (stringData['lastlogoff'] != null
        ? stringData['lastlogoff'].toString()
        : "");
    String personaState = (stringData['personastate'] != null
        ? stringData['personastate'].toString()
        : "");
    String realName = (stringData['realname'] != null
        ? stringData['realname'].toString()
        : "");
    String primaryClanID = (stringData['primaryclanid'] != null
        ? stringData['primaryclanid'].toString()
        : "");
    String timeCreated = (stringData['timecreated'] != null
        ? stringData['timecreated'].toString()
        : "");
    String personaStateFlags = (stringData['personastateflags'] != null
        ? stringData['personastateflags'].toString()
        : "");
    String countryCode = (stringData['loccountrycode'] != null
        ? stringData['loccountrycode'].toString()
        : "");

    return PlayerSummary(
        communityVisibility,
        profileState,
        personaName,
        profileURL,
        avatar,
        avatarMedium,
        avatarFull,
        avatarHash,
        lastLogoff,
        personaState,
        realName,
        primaryClanID,
        timeCreated,
        personaStateFlags,
        countryCode);
  }

  void printSummary() {
    print("communityVisibility: " + communityvisibilitystate.toString());
    print("profileState: " + profilestate.toString());
    print("personaName: " + personaname);
    print("profileURL: " + profileurl);
    print("avatar: " + avatar);
    print("avatarMedium: " + avatarmedium);
    print("avatarFull: " + avatarfull);
    print("avatarHash: " + avatarhash);
    print("lastLogoff: " + lastlogoff.toString());
    print("personaState: " + personastate.toString());
    print("realName: " + realname);
    print("primaryClanID: " + primaryclanid.toString());
    print("timeCreated: " + timecreated.toString());
    print("personaStateFlags: " + personastateflags.toString());
    print("countryCode: " + loccountrycode.toString());
  }

  Map<String, dynamic> toJSON() {
    return {
      "communityvisibilitystate": communityvisibilitystate,
      "profilestate": profilestate,
      "personaname": personaname,
      "profileurl": profileurl,
      "avatar": avatar,
      "avatarmedium": avatarmedium,
      "avatarfull": avatarfull,
      "avatarhash": avatarhash,
      "lastlogoff": lastlogoff,
      "personastate": personastate,
      "realname": realname,
      "primaryclanid": primaryclanid,
      "timecreated": timecreated,
      "personastateflags": personaname,
      "loccountrycode": loccountrycode
    };
  }
}
