import "package:flutter/material.dart";

class GameButton extends StatelessWidget {
  // const GameButton({Key? key}) : super(key: key);

  final int? counter,buttonContent;
  final dynamic? onGestureTap;

  GameButton({this.counter,this.onGestureTap,this.buttonContent});

  @override
  Widget build(BuildContext context) {

    String text1 = buttonContent == 1 ? "X" : "";
    String text2 = buttonContent == 2 ? "O" : text1;

    Color color1 = buttonContent == 1? Colors.redAccent : Colors.white;
    Color color2 = buttonContent == 2? Colors.blue : color1;

    return GestureDetector(
      onTap:(){
        onGestureTap(counter);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.24,
        height: MediaQuery.of(context).size.height * 0.155,
        color: Colors.blueGrey[100],
        child: Center(
          child : Text(
            text2,
            style:TextStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.bold,
              color: color2,
            ),
          ),
        ),
      ),
    );
  }
}
