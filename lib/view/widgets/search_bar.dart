import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_data.dart';
import 'package:my_games_tracker/core/game_model.dart';
import 'package:my_games_tracker/services/steamAPI.dart';
import 'package:my_games_tracker/view/widgets/game_list.dart';

import 'error_text.dart';

class SearchBar extends SearchDelegate<String> {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<GameModel>>(future: SteamAPI.getSearchStuff(query), builder: (BuildContext context, AsyncSnapshot<List<GameModel>> s) {
      if (!s.hasData) {
        return Center(
          child: CircularProgressIndicator(
              color: Theme.of(context).indicatorColor),
        );
      } else if (s.hasError) {
        return ErrorText("Error: Could not find search results.",
            FontWeight.normal, 25.0);
      } else {
        return GameList(games: s.data!, isExplore: true);
      }
    });

    // builder: (BuildContext context, AsyncSnapshot<PlayerSummary> s) {
    //             if (!s.hasData) {
    //               return Center(
    //                 child: CircularProgressIndicator(
    //                     color: Theme.of(context).indicatorColor),
    //               );
    //             } else if (s.hasError) {
    //               return ErrorText("Error: Could not fetch data for drawer.",
    //                   FontWeight.normal, 25.0);
    //             } else {
    //               return SettingsDrawer(s.data!, themeProvider);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // List<GameModel> suggestionList = query.isEmpty
    //     ? allGames
    //     : allGames
    //         .where(
    //             (game) => game.name.toLowerCase().contains(query.toLowerCase()))
    //         .toList();


    return GameList(
      games: [],
      isExplore: true,
    );
  }
}
