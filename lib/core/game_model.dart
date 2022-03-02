class GameModel {
  final String title;
  final String image;

  GameModel(this.title, this.image);
  factory GameModel.fromJSON(Map<String, Object> data) {
    final String title = data['title'] as String;
    final String image = data['image'] as String;

    return GameModel(title, image);
  }

}
