import "package:flutter/material.dart";


class ScoreCard extends StatelessWidget {

  final String? title;
  final int? score;
  final Color? color;

  ScoreCard({this.score,this.title,this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              title!,
              style: TextStyle(
                fontSize: 20.0,
                color: color
              ),
            ),
            Text(
              "$score",
              style: TextStyle(
                fontSize: 30.0,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
