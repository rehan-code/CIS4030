import 'dart:core';
import 'package:html/parser.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class GameModel {
  String _category = "";
  String get category => _category;
  set category(String v) => {_category = v};
  String _appid = "";
  String get appid => _appid;
  String _name = "";
  String get name => _name;
  String _playtime_forever = "";
  String get playtime_forever => _playtime_forever;
  String _playtime_2weeks = "";
  String get playtime_2weeks => _playtime_forever;
  String _price_overview = "";
  String get price_overview => _price_overview;
  String _img_icon_url = "";
  String get img_icon_url => _img_icon_url;
  String _header_image = "";
  String get header_image => _header_image;
  String _detailed_description = "";
  String get detailed_description => _detailed_description;
  List<String> _publishers = [];
  List<String> get publishers => _publishers;
  List<String> _genres = [];
  List<String> get genres => _genres;
  String _rating = "";
  String get rating => _rating;
  bool _windows = false;
  bool get windows => _windows;
  bool _mac = false;
  bool get mac => _mac;
  bool _linux = false;
  bool get linux => _linux;

  static String sanitizeHTML(String dirtyString) {
    print("Dirty:");
    print(dirtyString);

    final document = parse(dirtyString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  GameModel(
      this._category,
      this._appid,
      this._name,
      this._playtime_forever,
      this._playtime_2weeks,
      this._price_overview,
      this._img_icon_url,
      this._header_image,
      this._detailed_description,
      this._publishers,
      this._genres,
      this._rating,
      this._windows,
      this._mac,
      this._linux);

  factory GameModel.fromSteamLibraryAPI(Map<String, dynamic> data) {
    final String appid = (data['appid'] as int).toString();
    final String name = data['name'] as String;
    final String playtime_forever = data['playtime_forever'] != null
        ? ((data['playtime_forever'] as int) / 60).toStringAsFixed(1)
        : "0.00";
    final String playtime_2weeks = data['playtime_2weeks'] != null
        ? ((data['playtime_2weeks'] as int) / 60).toStringAsFixed(1)
        : "0.00";
    final String img_icon_url = (data['img_icon_url'] as String).isEmpty
        ? "https://w7.pngwing.com/pngs/958/304/png-transparent-red-x-illustration-x-mark-check-mark-symbol-x-mark-miscellaneous-angle-hand.png"
        : "http://media.steampowered.com/steamcommunity/public/images/apps/${appid}/" +
            (data['img_icon_url'] as String) +
            ".jpg";

    return GameModel("none", appid, name, playtime_forever, playtime_2weeks, "",
        img_icon_url, "", "", [], [], "", false, false, false);
  }

  factory GameModel.fromSteamFeatureAPI(Map<String, dynamic> data) {
    final String app_id = (data['id'] as int).toString();
    final String name = (data['name'] as String);
    final String price_overview =
        ((data['final_price'] as int) / 100).toStringAsFixed(2) + "\$";
    final String header_image = (data['header_image'] as String).isEmpty
        ? "https://w7.pngwing.com/pngs/958/304/png-transparent-red-x-illustration-x-mark-check-mark-symbol-x-mark-miscellaneous-angle-hand.png"
        : data['header_image'] as String;
    final bool windows = data['windows_available'] as bool;
    final bool mac = data['mac_available'] as bool;
    final bool linux = data['linux_available'] as bool;

    return GameModel("none", app_id, name, "", "", price_overview, "",
        header_image, "", [], [], "", windows, mac, linux);
  }

  factory GameModel.fromSteamDetailsAPI(
      Map<String, dynamic> data, GameModel existingGame) {
    final String appid = (data['steam_appid'] as int).toString();
    final String name = data['name'] as String;
    final String price_overview = data['price_overview'] != null
        ? (data['price_overview']['final_formatted']) as String
        : "0.00\$";
    final String header_image = (data['header_image'] as String).isEmpty
        ? "https://w7.pngwing.com/pngs/958/304/png-transparent-red-x-illustration-x-mark-check-mark-symbol-x-mark-miscellaneous-angle-hand.png"
        : data['header_image'] as String;
    final String detailed_description = data['detailed_description'] as String;
    print("Parsing publishers:");
    final List<String> publishers = [];
    for (var publisher in data['publishers'] as List<dynamic>) {
      publishers.add(publisher as String);
    }

    print("Parsing genres:");
    final List<String> genres = [];
    for (var genre in data['genres'] as List<dynamic>) {
      genres.add(genre["description"]);
    }
    final String rating = (data['review_score'] as int).toString();
    final bool windows = data['platforms']['windows'] as bool;
    final bool mac = data['platforms']['mac'] as bool;
    final bool linux = data['platforms']['linux'] as bool;
    return GameModel(
        existingGame._category,
        appid,
        name,
        existingGame.playtime_forever,
        existingGame.playtime_2weeks,
        price_overview,
        existingGame.img_icon_url,
        header_image,
        detailed_description,
        publishers,
        genres,
        rating,
        windows,
        mac,
        linux);
  }

  factory GameModel.fromFirebase(Map<String, dynamic> data) {
    final String category = data['category'] as String;
    final String appid = data['appid'] as String;
    final String name = data["name"] as String;
    final String playtime_forever = data["playtime_forever"] as String;
    final String playtime_2weeks = data["playtime_2weeks"] as String;
    final String price_overview = data["price_overview"] as String;
    final String img_icon_url = data["img_icon_url"] as String;
    final String header_image = data["header_image"] as String;
    final String detailed_description = data["detailed_description"] as String;
    final List<String> publishers = data["publisher"] != null
        ? (data["publisher"] as List<dynamic>).isNotEmpty
            ? data["publisher"] as List<String>
            : []
        : [];
    final List<String> genres = data["genres"] != null
        ? (data["genres"] as List<dynamic>).isNotEmpty
            ? data["genres"] as List<String>
            : []
        : [];
    final String rating = data["rating"] as String;
    final bool windows = data["windows"] as bool;
    final bool mac = data["mac"] as bool;
    final bool linux = data["linux"] as bool;
    return GameModel(
        category,
        appid,
        name,
        playtime_forever,
        playtime_2weeks,
        price_overview,
        img_icon_url,
        header_image,
        detailed_description,
        publishers,
        genres,
        rating,
        windows,
        mac,
        linux);
  }

  Map<String, dynamic> toJSON() {
    return {
      "appid": _appid,
      "name": _name,
      "playtime_forever": _playtime_forever,
      "playtime_2weeks": _playtime_2weeks,
      "price_overview": _price_overview,
      "img_icon_url": _img_icon_url,
      "header_image": _header_image,
      "detailed_description": _detailed_description,
      "publishers": _publishers,
      "genres": _genres,
      "rating": _rating,
      "windows": _windows,
      "mac": _mac,
      "linux": _linux,
      "category": _category
    };
  }

  bool equals(GameModel game) {
    return _appid == game._appid;
  }
}
