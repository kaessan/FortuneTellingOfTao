import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fortune_telling_of_tao/result_page.dart';
import 'package:fortune_telling_of_tao/hexagram.dart';
import './yin_yang_icon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: MyHomePage(title: "Flutter Demo Home Page",),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String hexagram = '';
  int translations = 0;


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
          title: Text("易占アプリ"),
          actions: [
            Center(
              child: Icon(MyFlutterApp.yin_yang),
            )
          ],
        ),

        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: Colors.green,
            ),
            Column(
              children: [
                Container(
                    height: 500,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            MyFlutterApp.yin_yang,
                            size: 300,
                            color: Colors.black12,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Text("テスト")),
                            ElevatedButton(
                              child: Text("リザルトページ"),
                              onPressed: (){
                                _fortunetelling();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ResultPage(hexagram, translations)),
                                );
                              },
                            ),
                            ElevatedButton(
                              child: Text("static変数取れてるかテスト"),
                              onPressed: (){
                                print("CONST_HEXAGRAMS.hexagrams[0].name : " + CONST_HEXAGRAMS.hexagrams[0].name);
                                print("CONST_HEXAGRAMS.hexagrams[0].anotherLineMean : " + CONST_HEXAGRAMS.hexagrams[0].anotherLineMean);
                                print("\n\n");
                                print("CONST_HEXAGRAMS.hexagrams[1].name : " + CONST_HEXAGRAMS.hexagrams[12].name);
                                print("CONST_HEXAGRAMS.hexagrams[1].finalLineMean : " + CONST_HEXAGRAMS.hexagrams[12].finalLineMean);
                              },
                            )
                          ],
                        ),
                      ],
                    )
                ),
                Container(
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          child: const Text('占う'),
                          onPressed: _fortunetelling
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ),
    );
  }

  void _fortunetelling(){
    //筮竹を用いる易占の方法は、本筮法・中筮法・略筮法の3種類それぞれで筮竹を操作する回数が違う、
    //本筮法 => 十八変筮法とも言い筮竹を十八回操作する伝統的な方法『繋辞伝(けいじでん)』に記載されている、時間がかかるのであまり使われない。
    //中筮法 => 六変筮法とも言い筮竹を六回操作する中期的な内容(時勢の変化とかの社会情勢など)を占う際に使われる。
    //略筮法 => 三変筮法とも言い筮竹を三回操作する事の可否など短期的なものに使用、現代では一番多い占い方。
    //
    //形式にとらわれずにランダムな結果による答えの出し方で陰陽を出せば占いは成立するので、正しい解釈が必要。
    //
    //筮竹(ぜいちく)　　divingStick     : 50本の細い竹の棒、卦を立てる時・象数を出すために用いる。
    //算木(さんき)　　　divingBlock     : 正方形の板に、陰陽の印や八卦を表示したもの、筮竹を捌いて得た数を八卦に当てはめてその象を表示するのに使用。
    //筮筒(ぜいとう)　　divingCylinder  : 始めと終わりに筮竹をまとめておくもの
    //掛肋器(けろくき)　hangingRib      : 筮竹を数えたものをかけておくもの
    //爻(こう)        translations
    //
    //ここでは略筮法を記述する

    //List<String> yinYang = ["乾", "兌", "離", "震", "巽", "坎", "艮", "坤"];
    int divingStick = 50;

    int preResult = 0;
    int postResult = 0;
    int translationsResult = 0;

    //太極の決定
    divingStick--;

    //上卦の決定
    int random = math.Random().nextInt(divingStick-2) + 1;
    int result = (divingStick - random) % 8 + 1 - 1;
    preResult = result;
    print("上卦 : " + preResult.toString());
    //preResult = yinYang[result];
    //print("上卦 : " + preResult);

    //下卦の決定
    random = math.Random().nextInt(divingStick-2) + 1 - 1;
    result = (divingStick - random) % 8 + 1;
    postResult = result;
    print("下卦 : " + postResult.toString());
    //postResult = yinYang[result];
    //print("下卦 : " + postResult);

    //爻位の決定
    random = math.Random().nextInt(divingStick-2) + 1 - 1;
    result = (divingStick - random) % 6 + 1 - 1;
    translationsResult = result;
    print("爻位 : " + translationsResult.toString());

    String binaryResult = "";
    binaryResult += preResult.toRadixString(2).padLeft(3,'0');
    binaryResult += postResult.toRadixString(2).padLeft(3,'0');

    print(binaryResult);

    /*switch(result){
      case 0 :
        translationsResult = "初爻";
        break;
      case 1 :
        translationsResult = "二爻";
        break;
      case 2 :
        translationsResult = "三爻";
      case 3 :
        translationsResult = "四爻";
        break;
      case 4 :
        translationsResult = "五爻";
        break;
      case 5 :
        translationsResult = "上爻";
        break;
    }*/

    setState(() {
      hexagram = binaryResult;
      translations = translationsResult;
    });



  }
}