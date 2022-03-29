import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  static final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  bool doesIdExist(String steamID) {
    try {
      users.doc(steamID).get();
      return true;
    } catch (e) {
      return false;
    }
  }

  // static void addSteamID(String steamID) async {
  //   await users
  //       .add({"steamID": steamID})
  //       .then((value) => print("Steam ID added!"))
  //       .catchError((error) => print("Couldn't add steamID to DB: $error"));
  // }

  static Future<void> addSteamID(String steamID) {
    return users
        .doc(steamID)
        .set({
          "games": [],
          "currentlyPlaying": [],
          "completed": [],
          "planToPlay": [],
        })
        .then((value) => print("Steam ID added!"))
        .catchError((error) => print("Couldn't add steamID to DB: $error"));
  }
}
