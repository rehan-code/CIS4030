import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_games_tracker/view/widgets/game_tile.dart';
import '../../core/game_data.dart';
import '../../core/game_model.dart';

class GameList extends StatelessWidget {
  @override
  Widget build(BuildContext build) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var game in game_data)
            GameTile(GameModel.fromJSON(game)),
        ],
      ),
    );
  }
}