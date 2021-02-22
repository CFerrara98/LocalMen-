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
    precacheImage(AssetImage("images/047-menu.png"), context);
    precacheImage(AssetImage("images/update-arrows.png"), context);
    precacheImage(AssetImage("images/034-waiter.png"), context);
    // Pizzeria
    precacheImage(AssetImage("images/pizzeria/1.png"), context);
    precacheImage(AssetImage("images/pizzeria/2.png"), context);
    precacheImage(AssetImage("images/pizzeria/3.png"), context);
    precacheImage(AssetImage("images/pizzeria/4.png"), context);
    precacheImage(AssetImage("images/pizzeria/5.png"), context);
    precacheImage(AssetImage("images/pizzeria/6.png"), context);
    precacheImage(AssetImage("images/pizzeria/7.png"), context);
    precacheImage(AssetImage("images/pizzeria/8.png"), context);
    precacheImage(AssetImage("images/pizzeria/9.png"), context);
    precacheImage(AssetImage("images/pizzeria/10.png"), context);
    // Ristorante
    precacheImage(AssetImage("images/ristorante/1.png"), context);
    precacheImage(AssetImage("images/ristorante/2.png"), context);
    precacheImage(AssetImage("images/ristorante/3.png"), context);
    precacheImage(AssetImage("images/ristorante/4.png"), context);
    precacheImage(AssetImage("images/ristorante/5.png"), context);
    precacheImage(AssetImage("images/ristorante/6.png"), context);
    precacheImage(AssetImage("images/ristorante/7.png"), context);
    precacheImage(AssetImage("images/ristorante/8.png"), context);
    precacheImage(AssetImage("images/ristorante/9.png"), context);
    precacheImage(AssetImage("images/ristorante/10.png"), context);
    // Paninoteca
    precacheImage(AssetImage("images/paninoteca/1.png"), context);
    precacheImage(AssetImage("images/paninoteca/2.png"), context);
    precacheImage(AssetImage("images/paninoteca/3.png"), context);
    precacheImage(AssetImage("images/paninoteca/4.png"), context);
    precacheImage(AssetImage("images/paninoteca/5.png"), context);
    precacheImage(AssetImage("images/paninoteca/6.png"), context);
    precacheImage(AssetImage("images/paninoteca/7.png"), context);
    precacheImage(AssetImage("images/paninoteca/8.png"), context);
    precacheImage(AssetImage("images/paninoteca/9.png"), context);
    precacheImage(AssetImage("images/paninoteca/10.png"), context);
    // Sushi
    precacheImage(AssetImage("images/sushi/1.png"), context);
    precacheImage(AssetImage("images/sushi/2.png"), context);
    precacheImage(AssetImage("images/sushi/3.png"), context);
    precacheImage(AssetImage("images/sushi/4.png"), context);
    precacheImage(AssetImage("images/sushi/5.png"), context);
    precacheImage(AssetImage("images/sushi/6.png"), context);
    precacheImage(AssetImage("images/sushi/7.png"), context);
    precacheImage(AssetImage("images/sushi/8.png"), context);
    precacheImage(AssetImage("images/sushi/9.png"), context);
    precacheImage(AssetImage("images/sushi/10.png"), context);

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    loadImages(context);
    return MaterialApp(
      title: 'Local Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoadingScreen(),
    );
  }
}

/*
*
*       LOADING SCREEN HERE
*
* */

class LoadingScreen extends StatefulWidget {

  LoadingScreen({Key key}) : super(key: key);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();

}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
  }

  bool successfullyConnected = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        successfullyConnected = true;
      });
    } catch(e) {
      setState(() {
        successfullyConnected = false;
      });
    }

    if (successfullyConnected)
      Timer(
          Duration(
            seconds: 2,
          ),
          // CALLBACK
              () {
            print("Firebase loaded");
            Navigator.pushAndRemoveUntil(context,
            PageTransition(
              type: PageTransitionType.fade,
              child: Home(),
              inheritTheme: true,
              ctx: context,
              duration: Duration(milliseconds: 800),
            ), (route) => false);

          }
      );
    else {
      print("Error");
    }

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

}
