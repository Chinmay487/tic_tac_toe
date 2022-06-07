import "dart:async";

class GameBloc {
  late bool _isPlayer1;

  List<int> gameProgress = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  // Stream controller to get index of a button tapped
  final _buttonTappedIndexController = StreamController<int>();
  Stream<int> get tappedButtonIndexStream =>
      _buttonTappedIndexController.stream;
  Sink<int> get tappedButtonIndexSink => _buttonTappedIndexController.sink;

  // Stream controller to display game board
  final _gameBoardContentController = StreamController<List<int>>();
  Stream<List<int>> get gameBoardContentStream =>
      _gameBoardContentController.stream;
  Sink<List<int>> get gameBoardContentSink => _gameBoardContentController.sink;

  // Stream controller to get which player turn is there
  final _isPlayer1Controller = StreamController<bool>();
  Stream<bool> get isPlayer1Stream => _isPlayer1Controller.stream;
  Sink<bool> get isPlayer1Sink => _isPlayer1Controller.sink;

  void onButtonTap(int index) {
    // print("$_isPlayer1 $index");
    gameProgress[index] = _isPlayer1 ? 1 : 2;
    gameBoardContentSink.add(gameProgress);
    _isPlayer1 = !_isPlayer1;
    isPlayer1Sink.add(_isPlayer1);
    checkWinner();
  }

  void resetGame() {
    gameProgress = [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ];
    _isPlayer1 = true;
    gameBoardContentSink.add(gameProgress);
    isPlayer1Sink.add(_isPlayer1);
  }

  // 0 1 2
  // 3 4 5
  // 6 7 8

  void checkWinner() {
    if (gameProgress[0] == 1 && gameProgress[1] == 1 && gameProgress[2] == 1 ||
        gameProgress[3] == 1 && gameProgress[4] == 1 && gameProgress[5] == 1 ||
        gameProgress[6] == 1 && gameProgress[7] == 1 && gameProgress[8] == 1 ||
        gameProgress[0] == 1 && gameProgress[3] == 1 && gameProgress[6] == 1 ||
        gameProgress[1] == 1 && gameProgress[4] == 1 && gameProgress[7] == 1 ||
        gameProgress[2] == 1 && gameProgress[5] == 1 && gameProgress[8] == 1 ||
        gameProgress[0] == 1 && gameProgress[4] == 1 && gameProgress[8] == 1 ||
        gameProgress[2] == 1 && gameProgress[4] == 1 && gameProgress[6] == 1 ) {
      print("player 1 won");
      resetGame();
    }
    if (gameProgress[0] == 2 && gameProgress[1] == 2 && gameProgress[2] == 2 ||
        gameProgress[3] == 2 && gameProgress[4] == 2 && gameProgress[5] == 2 ||
        gameProgress[6] == 2 && gameProgress[7] == 2 && gameProgress[8] == 2 ||
        gameProgress[0] == 2 && gameProgress[3] == 2 && gameProgress[6] == 2 ||
        gameProgress[1] == 2 && gameProgress[4] == 2 && gameProgress[7] == 2 ||
        gameProgress[2] == 2 && gameProgress[5] == 2 && gameProgress[8] == 2 ||
        gameProgress[0] == 2 && gameProgress[4] == 2 && gameProgress[8] == 2 ||
        gameProgress[2] == 2 && gameProgress[4] == 2 && gameProgress[6] == 2 ) {
      print("player 2 won");
      resetGame();
    }

  }

  GameBloc() {
    _isPlayer1 = true;
    gameBoardContentSink.add(gameProgress);
    isPlayer1Sink.add(_isPlayer1);
    tappedButtonIndexStream.listen(onButtonTap);
  }

  void dispose() {
    _buttonTappedIndexController.close();
    _gameBoardContentController.close();
    _isPlayer1Controller.close();
  }
}
