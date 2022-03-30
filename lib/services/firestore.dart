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

    // users
    //     .doc(steamID)
    //     .collection("playingGames")
    //     .add({})
    //     .then((value) => print("Playing Games added!"))
    //     .catchError(
    //         (error) => print("Couldn't add playing games to DB: $error"));

    // users
    //     .doc(steamID)
    //     .collection("completedGames")
    //     .add({})
    //     .then((value) => print("Completed Games added!"))
    //     .catchError(
    //         (error) => print("Couldn't add completed games to DB: $error"));

    // users
    //     .doc(steamID)
    //     .collection("planToPlayGames")
    //     .add({})
    //     .then((value) => print("Plan to Play Games added!"))
    //     .catchError(
    //         (error) => print("Couldn't add plan to play games to DB: $error"));

    // users
    //     .doc(steamID)
    //     .collection("boughtGames")
    //     .add({})
    //     .then((value) => print("Bought Games added!"))
    //     .catchError(
    //         (error) => print("Couldn't add bought games to DB: $error"));
  }

  static Future<void> updateAllUserGames(
      String steamID, List<GameModel> newLibrary) async {
    List<GameModel> currLibrary = [];
    List<GameModel> updatedGamesList = [];

    try {
      QuerySnapshot snapshot =
          await users.doc(steamID).collection("allGames").get();
      if (snapshot.size > 0) {
        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          currLibrary.add(GameModel.fromFirebase(data));
        }
        updatedGamesList.addAll(currLibrary
            .where((oldGame) => (newLibrary
                .where((newGame) => newGame.appid == oldGame.appid)).isNotEmpty)
            .toList());

        updatedGamesList.addAll(newLibrary
            .where((newGame) => (currLibrary
                .where((oldGame) => newGame.appid == oldGame.appid)).isEmpty)
            .toList());
        print(updatedGamesList);
      } else {
        updatedGamesList = newLibrary;
      }

      // for(int i = 0; i < newLibrary.length; i++){
      //   if(currLibrary.contains(newLibrary[i].appid)){
      //     updatedGamesList.add(newLibrary[i]);
      //   }
      // }
      for (var game in updatedGamesList) {
        await users
            .doc(steamID)
            .collection("allGames")
            .doc(game.appid)
            .set(game.toJSON())
            .then((value) => print(game.name + " added!"))
            .catchError((error) => print(
                "Couldn't update User with steamID: '" +
                    steamID +
                    "'s games to DB: $error"));
      }
    } catch (e) {
      print(e);
    }
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

  static Future<void> updateCategory(
      String gameId, String currCategory, String newCategory) async {}
}
