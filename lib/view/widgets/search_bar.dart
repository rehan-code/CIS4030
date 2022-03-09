import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_data.dart';
import 'package:my_games_tracker/core/game_model.dart';
import 'package:my_games_tracker/view/widgets/game_list.dart';

class SearchBar extends SearchDelegate<String> {
  List<GameModel> allGames = game_data.map((game) => GameModel.fromJSON(game)).toList();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {query = "";}, icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () {close(context, "");},
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return GameList(games: allGames.where((game) => game.title.toLowerCase().startsWith(query.toLowerCase())).toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<GameModel> suggestionList = query.isEmpty ? allGames : allGames.where((game) => game.title.toLowerCase().startsWith(query.toLowerCase())).toList();

    return GameList(games: suggestionList);
  }
}
