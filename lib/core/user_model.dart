import 'package:my_games_tracker/core/game_model.dart';

class UserModel {
  final String steam_id;
  final String persona_name;
  final String profile_url;
  final String avatar;
  final String real_name;
  final String country_code;
  final List<GameModel>? games;

  UserModel(this.steam_id, this.persona_name, this.profile_url, this.avatar,
      this.real_name, this.country_code, this.games);

  void printUserModel() {
    print("<================================================================>");
    print("steam_id: " + steam_id);
    print("persona_name: " + persona_name);
    print("profile_url: " + profile_url);
    print("avatar: " + avatar);
    print("real_name: " + real_name);
    print("country_code: " + country_code);

    games?.forEach((game) {
      game.printGameModel();
    });

    print("<================================================================>");
  }
}
