import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_model.dart';
import 'package:my_games_tracker/view/widgets/game_list.dart';

import '../../core/game_data.dart';

class HomeWidget extends StatefulWidget {
  final List<GameModel> allGames;
  const HomeWidget({Key? key, required this.allGames}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  List<GameModel> allGames =
      game_data.map((game) => GameModel.fromSteamLibraryAPI(game)).toList();

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
    _timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => setState(() {
              allGames = game_data
                  .map((game) => GameModel.fromSteamLibraryAPI(game))
                  .toList();
            }));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          // labelPadding: const EdgeInsets.only(top: 25),
          // labelColor: Theme.of(context).primaryColor,
          // indicatorColor: Theme.of(context).tabBarTheme.labelColor,
          indicatorWeight: 5,
          controller: _controller,
          tabs: const [
            Tab(
              child: SizedBox(
                width: 65,
                child: Text(
                  "All",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Tab(
              child: SizedBox(
                width: 65,
                child: Text(
                  "PLAYING",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Tab(
              child: SizedBox(
                width: 65,
                child: Text(
                  "COMPLETE",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Tab(
              child: SizedBox(
                width: 65,
                child: Text(
                  "WISHLIST",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Tab(
              child: SizedBox(
                width: 65,
                child: Text(
                  "UNPLAYED",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            height: 100,
            child: TabBarView(controller: _controller, children: [
              GameList(
                games: widget.allGames,
                isExplore: false,
              ),
              GameList(
                games: game_data
                    .map((game) => GameModel.fromSteamLibraryAPI(game))
                    .toList(),
                isExplore: false,
              ),
              // games: allGames
              //     .where((game) => game.category.contains('playing'))
              //     .toList()),
              GameList(
                games: game_data
                    .map((game) => GameModel.fromSteamLibraryAPI(game))
                    .toList(),
                isExplore: false,
              ),
              // games: allGames
              //     .where((game) => game.category.contains('complete'))
              //     .toList()),
              GameList(
                games: game_data
                    .map((game) => GameModel.fromSteamLibraryAPI(game))
                    .toList(),
                isExplore: false,
              ),
              // games: allGames
              //     .where((game) => game.category.contains('planned'))
              //     .toList()),
              GameList(
                games: game_data
                    .map((game) => GameModel.fromSteamLibraryAPI(game))
                    .toList(),
                isExplore: false,
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
