import "dart:async";

class GameBloc {
  late bool _isPlayer1;
  List<int> points = [0,0];

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

  // Stream controller to get is there a winner or not
  final _gameWinnerController = StreamController<int>();
  Stream<int> get winnerStream => _gameWinnerController.stream;
  Sink<int> get winnerSink => _gameWinnerController.sink;

  final _playerPointsController = StreamController<List<int>>();
  Stream<List<int>> get playerPointsStream => _playerPointsController.stream;
  Sink<List<int>> get playerPointsSink => _playerPointsController.sink;

  void onButtonTap(int index) {
    gameProgress[index] = _isPlayer1 ? 1 : 2;
    gameBoardContentSink.add(gameProgress);
    _isPlayer1 = !_isPlayer1;
    isPlayer1Sink.add(_isPlayer1);
    int winner = checkWinner();
    if(winner == 1 || winner == 2 || winner == 0){
      playerPointsSink.add(points);
      winnerSink.add(winner);
    }
  }

  void resetGame() {
    gameProgress = [0,0,0,0,0,0,0,0,0,];
    _isPlayer1 = true;
    gameBoardContentSink.add(gameProgress);
    isPlayer1Sink.add(_isPlayer1);
    winnerSink.add(-1);
  }

  void resetProgress(){
    resetGame();
    points[0] = 0;
    points[1] = 0;
    playerPointsSink.add(points);
  }

  // 0 1 2
  // 3 4 5
  // 6 7 8

  int checkWinner() {
    if (gameProgress[0] == 1 && gameProgress[1] == 1 && gameProgress[2] == 1 ||
        gameProgress[3] == 1 && gameProgress[4] == 1 && gameProgress[5] == 1 ||
        gameProgress[6] == 1 && gameProgress[7] == 1 && gameProgress[8] == 1 ||
        gameProgress[0] == 1 && gameProgress[3] == 1 && gameProgress[6] == 1 ||
        gameProgress[1] == 1 && gameProgress[4] == 1 && gameProgress[7] == 1 ||
        gameProgress[2] == 1 && gameProgress[5] == 1 && gameProgress[8] == 1 ||
        gameProgress[0] == 1 && gameProgress[4] == 1 && gameProgress[8] == 1 ||
        gameProgress[2] == 1 && gameProgress[4] == 1 && gameProgress[6] == 1 ) {
      points[0] = points[0] + 1;
      return 1;
    }
    if (gameProgress[0] == 2 && gameProgress[1] == 2 && gameProgress[2] == 2 ||
        gameProgress[3] == 2 && gameProgress[4] == 2 && gameProgress[5] == 2 ||
        gameProgress[6] == 2 && gameProgress[7] == 2 && gameProgress[8] == 2 ||
        gameProgress[0] == 2 && gameProgress[3] == 2 && gameProgress[6] == 2 ||
        gameProgress[1] == 2 && gameProgress[4] == 2 && gameProgress[7] == 2 ||
        gameProgress[2] == 2 && gameProgress[5] == 2 && gameProgress[8] == 2 ||
        gameProgress[0] == 2 && gameProgress[4] == 2 && gameProgress[8] == 2 ||
        gameProgress[2] == 2 && gameProgress[4] == 2 && gameProgress[6] == 2 ) {
      points[1] = points[1] + 1;
      return 2;
    }
    if(!gameProgress.contains(0)){
      return 0;
    }
    return -1;
  }

  GameBloc() {
    _isPlayer1 = true;
    gameBoardContentSink.add(gameProgress);
    isPlayer1Sink.add(_isPlayer1);
    winnerSink.add(checkWinner());
    playerPointsSink.add(points);
    tappedButtonIndexStream.listen(onButtonTap);
  }

  void dispose() {
    _buttonTappedIndexController.close();
    _gameBoardContentController.close();
    _isPlayer1Controller.close();
    _gameWinnerController.close();
    _playerPointsController.close();
  }
}
