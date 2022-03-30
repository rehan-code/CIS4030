import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_model.dart';
import 'game_options.dart';
import 'game_details.dart';

class GameTile extends StatelessWidget {
  final bool isExplore;
  final GameModel game;
  GameTile({Key? key, required this.game, required this.isExplore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
        onTap: () => showSteamAppBottomSheet(context, game, isExplore),
        child: Card(
            child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // padding: EdgeInsets.all(8),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(game.img_icon_url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            game.name,
                            style: TextStyle(fontSize: 20),
                            overflow: TextOverflow.visible,
                          )),
                      Text(
                          isExplore
                              ? "Price ${game.price_overview}"
                              : "Play Time: ${game.playtime_forever}",
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    ]),
              ),
            ),
            GameOptions(game: game),
          ],
        )),
      ),
    );
  }
}
