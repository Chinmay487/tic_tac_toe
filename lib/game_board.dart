import "package:flutter/material.dart";

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  List<Widget> getGameBoard(){
    List<Widget> columnElements = [];
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
              GestureDetector(
                onTap:(){
                  print("tapping $i $j counter : $counter");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.24,
                  height: MediaQuery.of(context).size.height * 0.155,
                  color: Colors.blueGrey[100],
                  child: const Center(
                    child : Text(
                        "X",
                      style:TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              )
            );
            counter += 1;
          } else {
            // for vertical lines
            rowElement.add(
              Container(
                height: MediaQuery.of(context).size.height * 0.157,
                width: MediaQuery.of(context).size.width * 0.035,
                color: Colors.black,
              ),
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
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.014,
            color: Colors.black,
          ),
        );
      }
    }
    return columnElements;
  }


  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width*0.8,
        height: MediaQuery.of(context).size.height*0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: getGameBoard(),
        ),
      ),
    );
  }
}
