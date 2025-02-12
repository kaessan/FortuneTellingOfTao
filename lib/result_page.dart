import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //機種ごとの画面サイズを取得
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Result Page"),
        ),
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: Colors.green,
            ),
            Container(
              height: height,
              width: width,
              color: Colors.white,
              margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 50),
            ),
          ],
        )
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}