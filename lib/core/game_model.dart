class GameModel {
  final String title;
  final String image;
  final String description;
  final int playtime;
  final int rating;

  GameModel(this.title, this.image, this.description, this.playtime, this.rating);
  factory GameModel.fromJSON(Map<String, Object> data) {
    final String title = data['title'] as String;
    final String image = data['image'] as String;
    final String description = data['description'] as String;
    final int playtime = data['hours played'] as int;
    final int rating = data['rating'] as int;

    return GameModel(title, image, description, playtime, rating);
  }
}
