import "package:flutter/material.dart";
import "./game_button.dart";
import "./lines.dart";
import "./game_bloc.dart";

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  final GameBloc _gameBloc = GameBloc();

  void onGestureTapFunction(int index){
    _gameBloc.tappedButtonIndexSink.add(index);
  }

  List<Widget> getGameBoard(List<int>? gameData){
    List<Widget> columnElements = [];
    List<int> gameProgress = gameData ?? [0,0,0,0,0,0,0,0,0];
    // gameProgress[3] = 2;
    int counter = 0;
    for(int i=0;i<5;i++){
      // for each row
      List<Widget> rowElement = [];
      if(i%2==0){
        //for each row
        for(int j=0;j<5;j++){
          if(j%2==0){
            // for each button
            rowElement.add(
              GameButton(
                counter: counter,
                onGestureTap: onGestureTapFunction,
                buttonContent : gameProgress[counter],
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
            children: <Widget>[ ...rowElement ],
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


  @override
  void dispose(){
    super.dispose();
    _gameBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.12,
          color: Colors.red,
          // child: Row(
          //   children: [
          //     Column(),
          //     Column(),
          //   ],
          // ),
        ),
        Center(
          child:StreamBuilder(
            stream: _gameBloc.isPlayer1Stream,
            initialData: true,
            builder: (context,snapshot){
              dynamic info = snapshot.data;
              String displayText = info ? "Player 1's turn" : "Player 2's turn";
              return Text(
                displayText,
                style: TextStyle(
                  fontSize: 30.0,
                  color: info ? Colors.red : Colors.blue,
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          height: MediaQuery.of(context).size.height*0.5,
          child: StreamBuilder(
            stream: _gameBloc.gameBoardContentStream,
            initialData: const [
              0,0,0,
              0,0,0,
              0,0,0
            ],
            builder: (context,snapshot){
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
          // color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: (){
                  _gameBloc.resetGame();
                },
                child: const Text("Reset Game"),
              ),
              ElevatedButton(
                onPressed: (){},
                child: const Text("Reset Stats"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
