import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_games_tracker/view/widgets/game_tile.dart';
import '../../core/game_data.dart';
import '../../core/game_model.dart';

class GameList extends StatelessWidget {
  final List<GameModel> games;
  final bool isExplore;
  const GameList({Key? key, required this.games, required this.isExplore})
      : super(key: key);
  @override
  Widget build(BuildContext build) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (games.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text("No Games to display yet...",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
              ),
            )
          else
            for (var game in games)
              GameTile(
                game: game,
                isExplore: isExplore,
              ),
        ],
      ),
    );
  }
}
