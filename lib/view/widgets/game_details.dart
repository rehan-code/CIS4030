import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_model.dart';

Future showSteamAppBottomSheet(var context, GameModel game) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => GameInfo(
            gameModel: game,
          ));
}

class GameInfo extends StatefulWidget {
  final GameModel gameModel;

  GameInfo({
    Key? key,
    required this.gameModel,
  }) : super(key: key);

  @override
  State<GameInfo> createState() => _GameInfoState();
}

class _GameInfoState extends State<GameInfo> {
  // bool isLoading = true;
  // String title = "";
  // String imageUrl = "";
  // String description = "";

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance?.addPostFrameCallback((_) => getGameInfo(context));
  // }

  // void getGameInfo(BuildContext context) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   await Future.delayed(const Duration(seconds: 1));
  //   setState(() {
  //     isLoading = false;
  //     title = "Game Title";
  //     imageUrl = "url";
  //     description =
  //         "Game description Game descriptionGame descriptionGame descriptionGame descriptionGame descriptionGame descriptionGame descriptionGame descriptionGame descriptionGame descriptionGame descriptionGame descriptionGame descriptionGame descriptionGame description";
  //   });
  // }

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
          displayGameInfo(widget.gameModel.title, widget.gameModel.image,
              widget.gameModel.description),
        ]),
      ),
    );
  }
}

Widget displayGameInfo(String title, String imageUrl, String description) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Text(
              "o",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Image.network(imageUrl),
        const SizedBox(
          height: 20,
        ),
        Text(
          description,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );

Widget displayLoadingSpinner() => Column(
      children: const [
        SizedBox(
          height: 200,
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
