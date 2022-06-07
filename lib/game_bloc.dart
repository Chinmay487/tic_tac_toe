import "dart:async";

class GameBloc{
  late bool _isPlayer1;

  List<int> gameProgress = [
    0,0,0,
    0,0,0,
    0,0,0
  ];

  // Stream controller to get index of a button tapped
  final _buttonTappedIndexController = StreamController<int>();
  Stream<int> get tappedButtonIndexStream => _buttonTappedIndexController.stream;
  Sink<int> get tappedButtonIndexSink => _buttonTappedIndexController.sink;

  // Stream controller to display game board
  final _gameBoardContentController = StreamController<List<int>>();
  Stream<List<int>> get gameBoardContentStream => _gameBoardContentController.stream;
  Sink<List<int>> get gameBoardContentSink => _gameBoardContentController.sink;

  // Stream controller to get which player turn is there
  final _isPlayer1Controller = StreamController<bool>();
  Stream<bool> get isPlayer1Stream => _isPlayer1Controller.stream;
  Sink<bool> get isPlayer1Sink => _isPlayer1Controller.sink;

  void onButtonTap(int index){
    // print("$_isPlayer1 $index");
    gameProgress[index] = _isPlayer1 ? 1 : 2;
    gameBoardContentSink.add(gameProgress);
    _isPlayer1 = !_isPlayer1;
    isPlayer1Sink.add(_isPlayer1);
  }

  void resetGame(){
    gameProgress = [
      0,0,0,
      0,0,0,
      0,0,0,
    ];
    _isPlayer1 = true;
    gameBoardContentSink.add(gameProgress);
    isPlayer1Sink.add(_isPlayer1);
  }

  GameBloc(){
    _isPlayer1 = true;
    gameBoardContentSink.add(gameProgress);
    isPlayer1Sink.add(_isPlayer1);
    tappedButtonIndexStream.listen(onButtonTap);
  }

  void dispose(){
    _buttonTappedIndexController.close();
    _gameBoardContentController.close();
    _isPlayer1Controller.close();
  }


}


