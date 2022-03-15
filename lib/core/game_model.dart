import 'package:flutter/foundation.dart';

class GameModel {
  final String title;
  final String image;
  final String description;
  final int playtime;
  final int rating;
  String category;

  GameModel(this.title, this.image, this.description, this.playtime,
      this.rating, this.category);
  factory GameModel.fromJSON(Map<String, Object> data) {
    final String title = data['title'] as String;
    final String image = data['image'] as String;
    final String description = data['description'] as String;
    final int playtime = data['hours played'] as int;
    final int rating = data['rating'] as int;
    final String category = data['category'] as String;

    return GameModel(title, image, description, playtime, rating, category);
  }

  void printGameModel() {
    print("<-------------------------------------------------->");
    print("title: " + title);
    print("image: " + image);
    print("description: " + description);
    print("playTime: " + playtime.toString());
    print("rating: " + rating.toString());
    print("category: " + category);
    print("<-------------------------------------------------->");
  }
}
