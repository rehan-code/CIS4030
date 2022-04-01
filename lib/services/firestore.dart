import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_model.dart';
import 'package:my_games_tracker/view/widgets/settings_drawer.dart';
import 'package:my_games_tracker/view/widgets/theme_provider.dart';

import '../core/player_summary.dart';
import 'steamAPI.dart';

class FireStore {
  static String _steamID = "";
  set steamID(String v) => {_steamID = v};

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
    _steamID = steamID;
    PlayerSummary summary =
        PlayerSummary.fromJSON(await SteamAPI.getPlayerSummary(_steamID));

    return users
        .doc(_steamID)
        .set(summary.toJSON())
        .then((value) => print("Steam ID added!"))
        .catchError((error) => print("Couldn't add steamID to DB: $error"));
  }

  static Future<void> updateAllUserGames(List<GameModel> newLibrary) async {
    List<GameModel> currLibrary = [];
    List<GameModel> updatedGamesList = [];

    try {
      QuerySnapshot snapshot =
          await users.doc(_steamID).collection("allGames").get();
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
            .doc(_steamID)
            .collection("allGames")
            .doc(game.appid)
            .set(game.toJSON())
            .then((value) => print(game.name + " added!"))
            .catchError((error) => print(
                "Couldn't update User with steamID: '" +
                    _steamID +
                    "'s games to DB: $error"));
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<PlayerSummary> getPlayerSummary() async {
    try {
      DocumentSnapshot userSummary = await users.doc(_steamID).get();
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
      String gameId, String currCategory, String newCategory) async {
    try {
      if (!(currCategory == "allGames")) {
        users.doc(_steamID).collection(currCategory).doc(gameId).delete();
      }
      users
          .doc(_steamID)
          .collection("allGames")
          .doc(gameId)
          .update({"category": newCategory});
      DocumentSnapshot snapshot =
          await users.doc(_steamID).collection("allGames").doc(gameId).get();
      Map<String, dynamic> newGame = snapshot.data() as Map<String, dynamic>;
      users.doc(_steamID).collection(newCategory).doc(gameId).set(newGame);
    } catch (e) {
      print("Error updating the category for '" + gameId + "': ");
      print(e.toString());
    }
  }

  static Stream<QuerySnapshot> getCategoryList(String category) {
    try {
      return users.doc(_steamID).collection(category).snapshots();
    } catch (e) {
      print("Error occurred while updating the game list for the '" +
          category +
          "' category: " +
          e.toString());
      return null as Stream<QuerySnapshot>;
    }
  }

  static Future<String> getCategory(String gameId) async {
    try {
      DocumentSnapshot snapshot =
          await users.doc(_steamID).collection("allGames").doc(gameId).get();
      if (snapshot.exists && snapshot.data() != null) {
        return snapshot.get("category") as String;
      }
      return "";
    } catch (e) {
      print("An error occured getting the category info for the game with id'" +
          gameId +
          "': " +
          e.toString());
      return "";
    }
  }
}
