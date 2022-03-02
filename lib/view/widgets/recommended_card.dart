import 'package:flutter/material.dart';
import 'package:my_games_tracker/core/game_model.dart';

class RecommendedCard extends StatelessWidget {
  final GameModel game;
  const RecommendedCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        // Danial add details widget to onTap here:
        onTap: () {},
        child: Card(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  game.image,
                  height: 200,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(5.0, 6.0)), color: Colors.deepPurple,),
                  width: 250,
                  height: 40,
                  // alignment: Alignment.center,
                  // color: Colors.blue,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(game.title, style: TextStyle(color: Colors.white, fontSize: 14, ), textAlign: TextAlign.center, ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
