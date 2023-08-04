import 'package:flutter/material.dart';

import '../game_page/game_page.dart';
import '../globals/global_variables.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key, required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('SnakeGameFlutter',
                style: TextStyle(color: Colors.white, fontSize: 20.0)),
            centerTitle: false),
        body: Container(
          color: colorDict['primary_color'],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Game Over',
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  'Score: $score',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => const GamePage()))
                  },
                  child: const Text('Restart'),
                )
              ],
            ),
          ),
        ));
  }
}
