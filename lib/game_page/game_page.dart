import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import '../game_over_page/game_over_page.dart';
import '../globals/global_variables.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late int _playerScore;
  late bool _hasStarted;
  late Animation<double> _snakeAnimation;
  late AnimationController _snakeController;
  List<int> _snake = [404, 405, 406, 407];
  final int _noOfSquares = 500;
  final Duration _duration = const Duration(milliseconds: 250);
  final int _squareSize = 20;
  late String _currentSnakeDirection;
  late int _snakeFoodPosition;
  Random _random = Random();

  @override
  void initState() {
    super.initState();
    _setUpGame();
  }

  void _setUpGame() {
    _playerScore = 0;
    _currentSnakeDirection = 'RIGHT';
    _hasStarted = true;
    do {
      _snakeFoodPosition = _random.nextInt(_noOfSquares);
    } while (_snake.contains(_snakeFoodPosition));
    _snakeController = AnimationController(vsync: this, duration: _duration);
    _snakeAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _snakeController);
  }

  void _gameStart() {
    Timer.periodic(Duration(milliseconds: _duration.inMilliseconds),
        (Timer timer) {
      _updateSnake();
      if (_hasStarted) {
        timer.cancel();
      }
    });
  }

  bool _gameOver() {
    for (int i = 0; i < _snake.length - 1; i++) {
      if (_snake.last == _snake[i]) {
        return true;
      }
    }
    return false;
  }

  void _updateSnake() {
    if (!_hasStarted) {
      setState(() {
        _playerScore = (_snake.length - 4) * 100;
        switch (_currentSnakeDirection) {
          case 'DOWN':
            if (_snake.last > _noOfSquares) {
              _snake.add(
                  _snake.last + _squareSize - (_noOfSquares + _squareSize));
            } else {
              _snake.add(_snake.last + _squareSize);
            }
            break;
          case 'UP':
            if (_snake.last < _squareSize) {
              _snake.add(
                  _snake.last - _squareSize + (_noOfSquares + _squareSize));
            } else {
              _snake.add(_snake.last - _squareSize);
            }
            break;
          case 'RIGHT':
            if ((_snake.last + 1) % _squareSize == 0) {
              _snake.add(_snake.last + 1 - _squareSize);
            } else {
              _snake.add(_snake.last + 1);
            }
            break;
          case 'LEFT':
            if ((_snake.last) % _squareSize == 0) {
              _snake.add(_snake.last - 1 + _squareSize);
            } else {
              _snake.add(_snake.last - 1);
            }
        }

        if (_snake.last != _snakeFoodPosition) {
          _snake.removeAt(0);
        } else {
          do {
            _snakeFoodPosition = _random.nextInt(_noOfSquares);
          } while (_snake.contains(_snakeFoodPosition));
        }

        if (_gameOver()) {
          setState(() {
            _hasStarted = !_hasStarted;
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
                  GameOverScreen(score: _playerScore)));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SnakeGameFlutter',
              style: TextStyle(
                  color: color_dict['appbar_text_color'], fontSize: 20.0)),
          centerTitle: false,
          actions: <Widget>[
            Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Score: $_playerScore',
                  style: TextStyle(fontSize: 16.0)),
            ))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            elevation: 5,
            label: Text(
              _hasStarted ? 'Start' : 'Pause',
              style: TextStyle(),
            ),
            onPressed: () {
              setState(() {
                if (_hasStarted) {
                  _snakeController.forward();
                } else {
                  _snakeController.reverse();
                }
                _hasStarted = !_hasStarted;
                _gameStart();
              });
            },
            icon: AnimatedIcon(
                icon: AnimatedIcons.play_pause, progress: _snakeAnimation)),
        body: Container(
          color: color_dict['primary_color'],
          child: Center(
            child: GestureDetector(
              onVerticalDragUpdate: (DragUpdateDetails drag) {
                if (drag.delta.dy > 0 && _currentSnakeDirection != 'UP') {
                  _currentSnakeDirection = 'DOWN';
                } else if (drag.delta.dy < 0 &&
                    _currentSnakeDirection != 'DOWN') {
                  _currentSnakeDirection = 'UP';
                }
              },
              onHorizontalDragUpdate: (DragUpdateDetails drag) {
                if (drag.delta.dx > 0 && _currentSnakeDirection != 'LEFT') {
                  _currentSnakeDirection = 'RIGHT';
                } else if (drag.delta.dx < 0 &&
                    _currentSnakeDirection != 'RIGHT') {
                  _currentSnakeDirection = 'LEFT';
                }
              },
              child: Container(
                color: color_dict['game_border_color'],
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: _squareSize + _noOfSquares,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _squareSize),
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Container(
                        color: color_dict['game_color'],
                        padding: _snake.contains(index)
                            ? EdgeInsets.all(1)
                            : EdgeInsets.all(0),
                        child: ClipRRect(
                          borderRadius: index == _snakeFoodPosition ||
                                  index == _snake.last
                              ? BorderRadius.circular(7)
                              : _snake.contains(index)
                                  ? BorderRadius.circular(2.5)
                                  : BorderRadius.circular(1),
                          child: Container(
                              color: _snake.contains(index)
                                  ? color_dict['snake_color']
                                  : index == _snakeFoodPosition
                                      ? color_dict['apple_color']
                                      : color_dict['game_color']),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
