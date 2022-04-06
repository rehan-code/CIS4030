import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_model.dart';
import 'package:my_games_tracker/view/widgets/game_list.dart';

import '../../core/game_data.dart';
import '../../services/firestore.dart';

class HomeWidget extends StatefulWidget {
  final List<GameModel> allGames;
  const HomeWidget({Key? key, required this.allGames}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }

  List<GameModel> sortTheDamnDanielList(List<GameModel> data) {
    List<GameModel> newList = [];
    for (GameModel g in data) {
      newList.add(g);
    }
    newList.sort(((a, b) => double.parse(b.playtime_2weeks)
        .compareTo(double.parse(a.playtime_2weeks))));
    return newList;
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
                  "PLAN TO PLAY",
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
              // GameList(
              //   games: sortTheDamnDanielList(widget.allGames),
              //   isExplore: false,
              // ),
              StreamBuilder<QuerySnapshot>(
                stream: FireStore.getCategoryList("allGames"),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator()));
                  }
                  List<GameModel> allGames = snapshot.data!.docs
                      .map((doc) => GameModel.fromFirebase(
                          (doc as DocumentSnapshot).data()
                              as Map<String, dynamic>))
                      .toList();
                  return GameList(
                    games: sortTheDamnDanielList(allGames),
                    isExplore: false,
                  );
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FireStore.getCategoryList("playingGames"),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator()));
                  }
                  List<GameModel> playingGames = snapshot.data!.docs
                      .map((doc) => GameModel.fromFirebase(
                          (doc as DocumentSnapshot).data()
                              as Map<String, dynamic>))
                      .toList();
                  return GameList(
                    games: sortTheDamnDanielList(playingGames),
                    isExplore: false,
                  );
                },
              ),
              // games: allGames
              //     .where((game) => game.category.contains('playing'))
              //     .toList()),
              StreamBuilder<QuerySnapshot>(
                stream: FireStore.getCategoryList("completeGames"),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator()));
                  }
                  List<GameModel> playingGames = snapshot.data!.docs
                      .map((doc) => GameModel.fromFirebase(
                          (doc as DocumentSnapshot).data()
                              as Map<String, dynamic>))
                      .toList();
                  return GameList(
                    games: sortTheDamnDanielList(playingGames),
                    isExplore: false,
                  );
                },
              ),
              // games: allGames
              //     .where((game) => game.category.contains('complete'))
              //     .toList()),
              StreamBuilder<QuerySnapshot>(
                stream: FireStore.getCategoryList("plannedGames"),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator()));
                  }
                  List<GameModel> playingGames = snapshot.data!.docs
                      .map((doc) => GameModel.fromFirebase(
                          (doc as DocumentSnapshot).data()
                              as Map<String, dynamic>))
                      .toList();
                  return GameList(
                    games: sortTheDamnDanielList(playingGames),
                    isExplore: false,
                  );
                },
              ),
              // games: allGames
              //     .where((game) => game.category.contains('planned'))
              //     .toList()),
              StreamBuilder<QuerySnapshot>(
                stream: FireStore.getCategoryList("unplayedGames"),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator()));
                  }
                  List<GameModel> playingGames = snapshot.data!.docs
                      .map((doc) => GameModel.fromFirebase(
                          (doc as DocumentSnapshot).data()
                              as Map<String, dynamic>))
                      .toList();
                  return GameList(
                    games: sortTheDamnDanielList(playingGames),
                    isExplore: false,
                  );
                },
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
