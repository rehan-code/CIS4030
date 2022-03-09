import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_games_tracker/view/widgets/game_tile.dart';
import '../../core/game_data.dart';
import '../../core/game_model.dart';

class GameList extends StatelessWidget {
  final List<GameModel> games;
  const GameList({Key? key, required this.games}) : super(key: key);
  @override
  Widget build(BuildContext build) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var game in games)
            GameTile(game),
        ],
      ),
    );
  }
}