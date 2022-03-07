import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_model.dart';
import 'package:my_games_tracker/view/widgets/status_dropdown.dart';

class GameTile extends StatelessWidget {
  final GameModel game;
  GameTile(this.game);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
          child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // padding: EdgeInsets.all(8),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(game.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${game.title}",
                  ),
                  Text(
                    "Rating: ${game.rating}\n\nPlaytime: ${game.playtime}",
                    style: TextStyle(color: Colors.grey),
                  ),
                ]),
          ),
          StatusDropdown(),
        ],
      )),
    );
  }
}
