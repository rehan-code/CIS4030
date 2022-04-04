import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_data.dart';
import 'package:my_games_tracker/core/game_model.dart';
import 'package:my_games_tracker/services/firestore.dart';

class GameOptions extends StatefulWidget {
  final GameModel game;
  const GameOptions({Key? key, required this.game}) : super(key: key);

  @override
  State<GameOptions> createState() => _GameOptionsState();
}

class _GameOptionsState extends State<GameOptions> {
  String _currCategory = "";

  void setCurrCategory() async {
    _currCategory = await FireStore.getCategory(widget.game.appid);
  }

  @override
  Widget build(BuildContext context) {
    setCurrCategory();
    return PopupMenuButton<String>(
      onSelected: (String result) {
        FireStore.updateCategory(widget.game.appid, _currCategory, result);
        setState(() {
          _currCategory = result;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'allGames',
          child: MenuTile(
            title: 'All',
            selected: (_currCategory == "allGames"),
          ),
        ),
        PopupMenuItem<String>(
          value: 'playingGames',
          child: MenuTile(
            title: 'Playing',
            selected: (_currCategory == "playingGames"),
          ),
        ),
        PopupMenuItem<String>(
          value: 'completeGames',
          child: MenuTile(
            title: 'Complete',
            selected: (_currCategory == "completeGames"),
          ),
        ),
        PopupMenuItem<String>(
          value: 'plannedGames',
          child: MenuTile(
            title: 'Plan to Play',
            selected: (_currCategory == "plannedGames"),
          ),
        ),
        PopupMenuItem<String>(
          value: 'unplayedGames',
          child: MenuTile(
            title: 'Unplayed',
            selected: (_currCategory == "unplayedGames"),
          ),
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
