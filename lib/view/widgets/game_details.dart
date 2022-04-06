import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:my_games_tracker/core/game_model.dart';
import 'package:my_games_tracker/view/widgets/detail_text.dart';
import 'package:my_games_tracker/view/widgets/game_options.dart';
import 'package:url_launcher/url_launcher.dart';

const double detailTitleFontSize = 24;
const double detailFontSize = 16;

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
              ? const Padding(
                  padding: EdgeInsets.only(top: 275),
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
              child:
                  DetailText(game.name, FontWeight.normal, detailTitleFontSize),
            ),
            GameOptions(game: game, isExplore: isExplore)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Image.network(game.header_image),
        const SizedBox(
          height: 20,
        ),

        DetailText(
            isExplore
                ? "Price: " + game.price_overview
                : "Play Time: " + game.playtime_forever + " hours",
            FontWeight.normal,
            detailFontSize),
        DetailText("Score: " + game.rating + " / 10", FontWeight.normal,
            detailFontSize),
        Wrap(
          children: [
            DetailText("Publishers: ", FontWeight.normal, detailFontSize),
            for (int i = 0; i < game.publishers.length; i++)
              DetailText(
                  game.publishers[i] +
                      (i == game.publishers.length - 1 ? "" : ", "),
                  FontWeight.normal,
                  detailFontSize),
          ],
        ),

        Wrap(
          children: [
            DetailText("Genres: ", FontWeight.normal, detailFontSize),
            for (int i = 0; i < game.genres.length; i++)
              DetailText(
                  game.genres[i] + (i == game.genres.length - 1 ? "" : ", "),
                  FontWeight.normal,
                  detailFontSize),
          ],
        ),

        const SizedBox(
          height: 20,
        ),

        HtmlWidget(
          game.detailed_description,
          textStyle: const TextStyle(fontSize: detailFontSize),
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
