import 'package:flutter/material.dart';

import '../game_page/game_page.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key, required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            const Text(
              'Game Over',
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 16),
            Text(
              'Score: $score',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const GamePage()))
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}
