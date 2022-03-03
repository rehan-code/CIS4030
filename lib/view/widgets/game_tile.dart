import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_model.dart';

import 'game_details.dart';

class GameTile extends StatelessWidget {
  final GameModel game;
  GameTile(this.game);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          // isThreeLine: true,
          dense: true,
          contentPadding: EdgeInsets.all(6),
          leading: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(game.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(game.title),
          subtitle: Text('Rating: ${game.rating}\n\nPlaytime: ${game.playtime}'),
          trailing: IconButton(
            onPressed: () => showSteamAppBottomSheet(context, game),
            icon: Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}
