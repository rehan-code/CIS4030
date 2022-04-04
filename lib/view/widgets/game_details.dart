import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:my_games_tracker/core/game_model.dart';
import 'package:my_games_tracker/view/widgets/game_options.dart';
import 'package:url_launcher/url_launcher.dart';

Future showSteamAppBottomSheet(var context, GameModel game, bool isExplore) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => GameInfo(
            isExplore: isExplore,
            gameModel: game,
          ));
}

class GameInfo extends StatefulWidget {
  final GameModel gameModel;
  final bool isExplore;

  GameInfo({
    Key? key,
    required this.gameModel,
    required this.isExplore,
  }) : super(key: key);

  @override
  State<GameInfo> createState() => _GameInfoState();
}

class _GameInfoState extends State<GameInfo> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.9,
      minChildSize: 0.6,
      initialChildSize: 0.7,
      builder: (_, controller) => Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(controller: controller, children: [
          widget.gameModel.appid.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 275),
                  child: Center(
                    child: Text(
                      "Not A Game",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                )
              : displayGameInfo(widget.gameModel, widget.isExplore),
        ]),
      ),
    );
  }
}

Widget displayGameInfo(GameModel game, bool isExplore) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                game.name,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            GameOptions(game: game)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Image.network(game.header_image),
        const SizedBox(
          height: 20,
        ),

        Text(
          isExplore
              ? "Price: " + game.price_overview
              : "Play Time: " + game.playtime_forever + " hours",
        ),
        Text("Score: " + game.rating + "/10"),
        Wrap(
          children: [
            const Text(
              "Publishers: ",
            ),
            for (int i = 0; i < game.publishers.length; i++)
              Text(game.publishers[i] +
                  (i == game.publishers.length - 1 ? "" : ", ")),
          ],
        ),

        Wrap(
          children: [
            const Text(
              "Genres: ",
            ),
            for (int i = 0; i < game.genres.length; i++)
              Text(game.genres[i] + (i == game.genres.length - 1 ? "" : ", "))
          ],
        ),

        const SizedBox(
          height: 20,
        ),

        HtmlWidget(
          game.detailed_description,
          onTapUrl: (url) async {
            try {
              return await launch(url);
            } catch (e) {
              throw 'Could not launch $url';
            }
          },
        ),
        // Text(
        //   game.detailed_description,
        //   style: const TextStyle(fontSize: 18),
        // ),
      ],
    );

Widget displayLoadingSpinner(BuildContext context) => Column(
      children: [
        const SizedBox(
          height: 200,
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              color: Theme.of(context).indicatorColor,
            ),
          ),
        ),
      ],
    );
