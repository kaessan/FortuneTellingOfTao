import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fortune_telling_of_tao/result_page.dart';
import 'package:fortune_telling_of_tao/hexagram.dart';
import './yin_yang_icon.dart';

class ResultPage extends StatelessWidget{
  ResultPage(this.hexagram, this.translations);
  final String hexagram;
  final int translations;

  int hexNum = 0;
  int lineNum = 0;

  String strTranslation = "";
  String strOriginal = "";
  String strMean = "";

  @override
  Widget build(BuildContext context) {
    //機種ごとの画面サイズを取得
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    setHexagram();

    return Container(
      height: height,
      width: width,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Result Page"),
          actions: [
            Center(
              child: Icon(MyFlutterApp.yin_yang),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: height,
              width: width,
              color: Colors.green,
            ),
            //アイコン
            Container(
              height: height,
              width: width,
              color: Colors.white,
              margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 50),
              child: Column(
                children:[
                  //名前
                  Container(
                      width: width,
                      color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Text(CONST_HEXAGRAMS.hexagrams[hexNum].nameKana)),
                          Center(
                            child: Text(
                              CONST_HEXAGRAMS.hexagrams[hexNum].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 100
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  //記号
                  Container(
                    height: 200,
                      width: width,
                      color: Colors.blue,
                      child: Center(
                          child: Text(
                              CONST_HEXAGRAMS.hexagrams[hexNum].shape,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 200
                              ),
                          )
                      )
                  ),
                  //キーワード
                  Container(
                      width: width,
                      color: Colors.purple,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text(CONST_HEXAGRAMS.hexagrams[hexNum].keyWord)),
                      ],
                      ),
                  ),
                  //卦辞
                  Container(
                      width: width,
                      color: Colors.yellow,
                      child: Column(
                        children: [
                          Center(child: Text("卦辞")),
                          Center(child: Text(CONST_HEXAGRAMS.hexagrams[hexNum].originalOutline)),
                          Center(child: Text("(" + CONST_HEXAGRAMS.hexagrams[hexNum].meanOutline + ")")),
                        ],
                      ),
                  ),
                //象伝
                  Container(
                    width: width,
                    color: Colors.indigo,
                    child: Column(
                        children: [
                          Center(child: Text("象伝")),
                          Center(child: Text(CONST_HEXAGRAMS.hexagrams[hexNum].originalSummary)),
                          Center(child: Text("(" + CONST_HEXAGRAMS.hexagrams[hexNum].meanSummary + ")")),
                        ],
                   ),
                  ),
                  //本文
                  Container(
                      width: width,
                      color: Colors.tealAccent,
                      child: Column(
                        children: [
                          Center(child: Text(strTranslation)),
                          Center(child: Text(CONST_HEXAGRAMS.hexagrams[hexNum].originalLines[translations])),
                          Center(child: Text(CONST_HEXAGRAMS.hexagrams[hexNum].meanLines[translations])),
                        ],
                      ),
                  ),
                ]
              ),
            ),
          ],
        )
      ),
    );
  }



  void setHexagram(){
    lineNum = 10 + translations * 2;

    for(int i = 0; i < CONST_HEXAGRAMS.hexagrams.length; i++){
      if(CONST_HEXAGRAMS.hexagrams[i].binaryNumber == hexagram){
        hexNum = i;
      }
    }

    switch(translations){
      case 0 :
        strTranslation = "初爻";
        break;
      case 1 :
        strTranslation = "二爻";
        break;
      case 2 :
        strTranslation = "三爻";
      case 3 :
        strTranslation = "四爻";
        break;
      case 4 :
        strTranslation = "五爻";
        break;
      case 5 :
        strTranslation = "上爻";
        break;
    }
  }
}