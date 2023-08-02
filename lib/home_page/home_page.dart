import 'package:flutter/material.dart';

import '../game_page/game_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Snake Game Home Page'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.blue,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                OutlinedButton.icon(
                    onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const GamePage()))
                    },
                    icon: const Icon(
                      Icons.play_circle_filled,
                      color: Colors.white,
                      size: 30,
                    ),
                    label: const Text('Play', style: TextStyle(color: Colors.white, fontSize: 20)),),
              ]),
        ));
  }
}
