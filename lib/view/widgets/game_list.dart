import 'package:flutter/cupertino.dart';
import 'package:my_games_tracker/view/widgets/game_tile.dart';
import '../../core/game_data.dart';
import '../../core/game_model.dart';

class GameList extends StatelessWidget {
  @override
  Widget build(BuildContext build) {
    return ListView(
      children: [
        for (int i = 0; i < 3; i++)
          GameTile(GameModel.fromJSON(game_data[i])),
      ],
    );
  }
}