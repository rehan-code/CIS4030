import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_data.dart';
import 'package:my_games_tracker/core/game_model.dart';
import 'package:my_games_tracker/services/steamAPI.dart';
import 'package:my_games_tracker/view/widgets/game_list.dart';
import 'package:my_games_tracker/view/widgets/recommended_card.dart';
import 'package:my_games_tracker/view/widgets/search_bar.dart';

class Explore extends StatefulWidget {
  final Map<String, List<GameModel>> explorePageData;
  const Explore({Key? key, required this.explorePageData}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with SingleTickerProviderStateMixin {
  late TabController _controller;
  late List<Map<String, String>> _searchGameData;

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Spotlight:",
                style: TextStyle(fontSize: 18),
              ),
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: SearchBar());
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
        ),
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (var game in widget.explorePageData['specials']!)
                RecommendedCard(game: game)
            ],
          ),
        ),
        Container(
          // color: Colors.deepPurple,
          child: TabBar(
            // labelColor: Colors.white,
            // indicatorColor: Colors.white,
            controller: _controller,
            tabs: [
              Tab(
                  child: Text(
                "Coming Soon",
                textAlign: TextAlign.center,
              )),
              Tab(
                  child: Text(
                "Top Sellers",
                textAlign: TextAlign.center,
              )),
              Tab(
                  child: Text(
                "New Releases",
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: TabBarView(
              controller: _controller,
              children: [
                GameList(
                  games: widget.explorePageData['coming_soon']!,
                  isExplore: true,
                ),
                GameList(
                  games: widget.explorePageData['top_sellers']!,
                  isExplore: true,
                ),
                GameList(
                  games: widget.explorePageData['new_releases']!,
                  isExplore: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
