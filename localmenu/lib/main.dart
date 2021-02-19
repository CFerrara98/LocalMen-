import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localmenu/Utils/custom_bordered_text.dart';
import 'package:localmenu/home.dart';
import 'package:page_transition/page_transition.dart';

import 'Utils/Graphics/colors.dart';
import 'Utils/Graphics/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  void loadImages(BuildContext context){
    precacheImage(AssetImage("images/background_revert.png"), context);
    precacheImage(AssetImage("images/background.png"), context);
    precacheImage(AssetImage("images/003-chinese-food.png"), context);
    precacheImage(AssetImage("images/010-burger.png"), context);
    precacheImage(AssetImage("images/022-serving-dish.png"), context);
    precacheImage(AssetImage("images/023-pizza-slice.png"), context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    loadImages(context);
    return MaterialApp(
      title: 'Local Menu',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoadingScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    onPageStart();
  }

  @override
  Widget build(BuildContext context) {

    MediaQueryData mqd = MediaQuery.of(context);

    return Scaffold(
      body: Material(
        child: Container(
          color: customOrange,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background_revert.png'),
                  fit: BoxFit.cover,
                )
            ),
            padding: EdgeInsets.fromLTRB(mqd.size.width * 20 / 100, 0, mqd.size.width * 20 / 100, 0),
            child: Center(
              child: BorderedText(
                strokeColor: customOrange,
                strokeWidth: 16,
                child: AutoSizeText(
                  "LOCAL MENU",
                  maxLines: 1,
                  minFontSize: 16,
                  style: GoogleFonts.ptSansNarrow(
                    fontSize: 80,
                    color: customWhite,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onPageStart(){
    Timer(
        Duration(
          seconds: 3,
        ),
        // CALLBACK
        () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: Home(),
              inheritTheme: true,
              ctx: context,
              duration: Duration(milliseconds: 800),
            ),
          );
        }
    );
  }

}
