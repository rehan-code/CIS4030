class GameModel {
  final String title;
  final String image;
  final String description;

  GameModel(this.title, this.image, this.description);
  factory GameModel.fromJSON(Map<String, Object> data) {
    final String title = data['title'] as String;
    final String image = data['image'] as String;
    final String description = data['description'] as String;

    return GameModel(title, image, description);
  }
}
