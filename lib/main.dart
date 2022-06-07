import "package:flutter/material.dart";
import "./game_board.dart";

void main(){
  runApp(const Root());
}


class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tic Tac Toe"),
        ),
        body: GameBoard(),
      ),
    );
  }
}

