import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_data.dart';
import 'package:my_games_tracker/core/game_model.dart';
import 'package:my_games_tracker/services/firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'error_text.dart';

class GameOptions extends StatefulWidget {
  final GameModel game;
  final bool isExplore;
  const GameOptions({Key? key, required this.game, required this.isExplore})
      : super(key: key);

  @override
  State<GameOptions> createState() => _GameOptionsState();
}

class _GameOptionsState extends State<GameOptions> {
  String _currentCategory = "";

  void setCurrentCategory() async {
    String category = await FireStore.getCategory(widget.game.appid);
    setState(() {
      _currentCategory = category;
    });
  }

  Future<List<PopupMenuEntry<String>>> doesGameExist() async {
    return await FireStore.doesGameExist(widget.game.appid)
        ? inLibraryWidgets()
        : inExploreWidgets();
    
  }

  List<PopupMenuEntry<String>> inLibraryWidgets() {
    return [
      PopupMenuItem<String>(
        value: 'allGames',
        child: MenuTile(
          title: 'All',
          selected: (_currentCategory == "allGames"),
        ),
      ),
      PopupMenuItem<String>(
        value: 'playingGames',
        child: MenuTile(
          title: 'Playing',
          selected: (_currentCategory == "playingGames"),
        ),
      ),
      PopupMenuItem<String>(
        value: 'completeGames',
        child: MenuTile(
          title: 'Complete',
          selected: (_currentCategory == "completeGames"),
        ),
      ),
      PopupMenuItem<String>(
        value: 'plannedGames',
        child: MenuTile(
          title: 'Plan to Play',
          selected: (_currentCategory == "plannedGames"),
        ),
      ),
      PopupMenuItem<String>(
        value: 'unplayedGames',
        child: MenuTile(
          title: 'Unplayed',
          selected: (_currentCategory == "unplayedGames"),
        ),
      ),
    ];
  }

  List<PopupMenuEntry<String>> inExploreWidgets() {
    return [
      PopupMenuItem<String>(
        value: 'steamPage',
        child: MenuTile(
          title: 'Steam Page',
          selected: (_currentCategory == "steamPage"),
        ),
      ),
    ];
  }

  List<Widget> exploreWidgets = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: doesGameExist(),
        builder: (BuildContext, AsyncSnapshot<List<PopupMenuEntry<String>>> s) {
          if (!s.hasData) {
            return Center(
              child: PopupMenuButton<String>(
                itemBuilder: (context) => [],
              ),
            );
          } else if (s.hasError) {
            return ErrorText("Error", FontWeight.normal, 18.0);
          } else {
            setCurrentCategory();
            return PopupMenuButton<String>(
              onSelected: (String result) async {
                if (result == "steamPage") {
                  try {
                    await launch("https://store.steampowered.com/app/" +
                        widget.game.appid);
                  } catch (e) {
                    throw 'Could not launch https://store.steampowered.com/app/' +
                        widget.game.appid;
                  }
                  return;
                }
                await FireStore.updateCategory(
                    widget.game.appid, _currentCategory, result);
                setState(() {
                  _currentCategory = result;
                });
              },
              itemBuilder: (context) => s.data!,
            );
          }
        });
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
