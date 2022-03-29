import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_games_tracker/core/game_model.dart';
import 'package:my_games_tracker/view/widgets/settings_drawer.dart';
import 'package:my_games_tracker/view/widgets/theme_provider.dart';

import '../core/player_summary.dart';
import 'steamAPI.dart';

class FireStore {
  static final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static bool doesIdExist(String steamID) {
    try {
      users.doc(steamID).get();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> addSteamID(String steamID) async {
    PlayerSummary summary =
        PlayerSummary.fromJSON(await SteamAPI.getPlayerSummary(steamID));

    return users
        .doc(steamID)
        .set(summary.toJSON())
        .then((value) => print("Steam ID added!"))
        .catchError((error) => print("Couldn't add steamID to DB: $error"));
  }

  static Future<void> updateAllUserGames(
      String steamID, List<GameModel> updatedUserGames) async {
    for (var game in updatedUserGames) {
      await users
          .doc(steamID)
          .collection("games")
          .doc(game.title)
          .set(game.toJSON())
          .then((value) => print(game.title + " added!"))
          .catchError((error) => print("Couldn't add steamID to DB: $error"));
    }

    // return users
    //     .doc(steamID)
    //     .collection("games")
    //     .(newGames)
    //     .then((value) => print("Steam ID added!"))
    //     .catchError((error) => print("Couldn't add steamID to DB: $error"));
  }

  static Future<PlayerSummary> getPlayerSummary(String steamID) async {
    try {
      DocumentSnapshot userSummary = await users.doc(steamID).get();
      if (userSummary.exists && userSummary.data() != null) {
        Map<String, dynamic> dat = userSummary.data() as Map<String, dynamic>;
        // dat.forEach((key, value) {
        //   print("[" + key + "] -> " + value);
        // });
        PlayerSummary test = PlayerSummary.fromJSON(dat);
        //test.printSummary();
        return PlayerSummary.fromJSON(dat);
      }
      return null as PlayerSummary;
    } catch (e) {
      print("Couldn't fetch player's summary from the DB: $e");
      return null as PlayerSummary;
    }
  }
}
