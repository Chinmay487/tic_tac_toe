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

  // Stram controller to display game board
  final _gameBoardContentController = StreamController<List<int>>();
  Stream<List<int>> get gameBoardContentStream => _gameBoardContentController.stream;
  Sink<List<int>> get gameBoardContentSink => _gameBoardContentController.sink;

  void onButtonTap(int index){
    print("$_isPlayer1 $index");
    gameProgress[index] = _isPlayer1 ? 1 : 2;
    gameBoardContentSink.add(gameProgress);
    _isPlayer1 = !_isPlayer1;
  }

  GameBloc(){
    _isPlayer1 = true;
    gameBoardContentSink.add(gameProgress);
    tappedButtonIndexStream.listen(onButtonTap);
  }

  void dispose(){
    gameBoardContentSink.close();
  }


}


