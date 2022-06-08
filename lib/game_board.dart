import "package:flutter/material.dart";
import "./game_button.dart";
import "./lines.dart";
import "./game_bloc.dart";
import "./scoreboard.dart";

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final GameBloc _gameBloc = GameBloc();

  void displayDialog(String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Game Result"),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('Rematch'),
                onPressed: () {
                  _gameBloc.resetGame();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _GameBoardState() {
    _gameBloc.winnerStream.listen((event) {
      switch (event) {
        case 0:
          displayDialog("It's Draw");
          break;
        case 1:
          displayDialog("Player 1 Won");
          break;
        case 2:
          displayDialog("Player 2 Won");
          break;
        default:
          null;
      }
    });
  }

  void onGestureTapFunction(int index) {
    _gameBloc.tappedButtonIndexSink.add(index);
  }

  List<Widget> getGameBoard(List<int>? gameData) {
    List<Widget> columnElements = [];
    List<int> gameProgress = gameData ?? [0, 0, 0, 0, 0, 0, 0, 0, 0];
    // gameProgress[3] = 2;
    int counter = 0;
    for (int i = 0; i < 5; i++) {
      // for each row
      List<Widget> rowElement = [];
      if (i % 2 == 0) {
        //for each row
        for (int j = 0; j < 5; j++) {
          if (j % 2 == 0) {
            // for each button
            rowElement.add(
              GameButton(
                counter: counter,
                onGestureTap: onGestureTapFunction,
                buttonContent: gameProgress[counter],
              ),
            );
            counter += 1;
          } else {
            // for vertical lines
            rowElement.add(
              VerticalLine(),
            );
          }
        }
        columnElements.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[...rowElement],
          ),
        );
      } else {
        //for horizontal lines
        columnElements.add(
          HorizontalLine(),
        );
      }
    }
    return columnElements;
  }

  Future<void> showMessage() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Some Title"),
            content: const Text("Some Content"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _gameBloc.resetGame();
                },
                child: const Text("Rematch"),
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _gameBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: StreamBuilder(
            stream: _gameBloc.playerPointsStream,
              initialData: [0,0],
              builder: (context,snapshot){
              dynamic data = snapshot.data;
              var player1Point = data[0];
              var player2Point = data[1];
                return ScoreBoard(
                  player1Point: player1Point,
                  player2Point: player2Point,
                );
              },
          ),
        ),
        Center(
          child: StreamBuilder(
            stream: _gameBloc.isPlayer1Stream,
            initialData: true,
            builder: (context, snapshot) {
              dynamic info = snapshot.data;
              int playerNumber = info ? 1 : 2;
              return Text(
                "Player $playerNumber's turn",
                style: TextStyle(
                  fontSize: 30.0,
                  color: info ? Colors.red : Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          child: StreamBuilder(
            stream: _gameBloc.gameBoardContentStream,
            initialData: const [0, 0, 0, 0, 0, 0, 0, 0, 0],
            builder: (context, snapshot) {
              dynamic gameData = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: getGameBoard(gameData),
              );
            },
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _gameBloc.resetGame();
                },
                child: const Text("Reset Game"),
              ),
              ElevatedButton(
                onPressed: () {
                  _gameBloc.resetProgress();
                },
                child: const Text("Reset Stats"),
              )
            ],
          ),
        ),
      ],
    );
  }
}
