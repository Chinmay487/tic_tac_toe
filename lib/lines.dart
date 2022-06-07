import "package:flutter/material.dart";

class VerticalLine extends StatelessWidget {
  // const VerticalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.157,
      width: MediaQuery.of(context).size.width * 0.035,
      color: Colors.black,
    );
  }
}


class HorizontalLine extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.014,
      color: Colors.black,
    );
  }
}
