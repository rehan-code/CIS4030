import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_data.dart';
import 'package:my_games_tracker/core/game_model.dart';

class GameOptions extends StatefulWidget {
  final GameModel game;
  const GameOptions({Key? key, required this.game}) : super(key: key);

  @override
  State<GameOptions> createState() => _GameOptionsState();
}

class _GameOptionsState extends State<GameOptions> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        setState(() {
          widget.game.category = result;
        });
        for (var game in game_data) {
          if (game['title'] as String == widget.game.title) {
            game['category'] = result;
            break;
          }
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'none',
          child: MenuTile(
              title: 'None', selected: (widget.game.category == "none")),
        ),
        PopupMenuItem<String>(
          value: 'playing',
          child: MenuTile(
              title: 'Playing', selected: (widget.game.category == "playing")),
        ),
        PopupMenuItem<String>(
          value: 'complete',
          child: MenuTile(
              title: 'Complete',
              selected: (widget.game.category == "complete")),
        ),
        PopupMenuItem<String>(
          value: 'planned',
          child: MenuTile(
              title: 'Plan To Play',
              selected: (widget.game.category == "planned")),
        ),
      ],
    );
  }
}

class MenuTile extends StatelessWidget {
  final String title;
  final bool selected;

  const MenuTile({Key? key, required this.title, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const Spacer(),
        (selected ? const Icon(Icons.check_rounded) : const Text("")),
      ],
    );
  }
}
