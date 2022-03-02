import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_data.dart';
import 'package:my_games_tracker/core/game_model.dart';
import 'package:my_games_tracker/view/widgets/recommended_card.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Recommended:",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (var game in game_data)
                RecommendedCard(game: GameModel.fromJSON(game))
            ],
          ),
        ),
        Container(
          color: Colors.deepPurple,
          child: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            controller: _controller,
            tabs: [
              Tab(child: Text("New & Trending", textAlign: TextAlign.center,)),
              Tab(child: Text("Top Sellers",  textAlign: TextAlign.center,)),
              Tab(child: Text("Whats Being Experienced", textAlign: TextAlign.center,)),
            ],
          ),
        ),
        Container(
          height: 100,
          child: TabBarView(
            controller: _controller,
            children: [
              // Rehan replace these with listView:
              Text("New & Trending"),
              Text("Top Sellers"),
              Text("Whats Being Experienced")
            ],
          ),
        )
      ],
    );
  }
}
