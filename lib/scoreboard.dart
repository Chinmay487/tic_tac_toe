import "package:flutter/material.dart";
import "./score_card.dart";


class ScoreBoard extends StatelessWidget {
  // const ScoreBoard({Key? key}) : super(key: key);

  final int? player1Point,player2Point;
  ScoreBoard({this.player1Point,this.player2Point});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        children: <Widget>[
          ScoreCard(score: player1Point,title: "Player 1",color: Colors.red,),
          ScoreCard(score: player2Point,title: "Player 2",color: Colors.blue[900],),
        ],
      ),
    );
  }
}
