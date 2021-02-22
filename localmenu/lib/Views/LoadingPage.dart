import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localmenu/Beans/Locale.dart';
import 'package:localmenu/Utils/custom_bordered_text.dart';
import 'package:localmenu/home.dart';
import 'package:page_transition/page_transition.dart';

import '../Utils/Graphics/colors.dart';
import '../Utils/Graphics/colors.dart';
import '../detailspage.dart';

class LoadingScreen extends StatefulWidget {

  LocalePreview l ;
  String categoria;

  LoadingScreen(this.l, this.categoria);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();

}

class _LoadingScreenState extends State<LoadingScreen> {

  Locale locale = null;

  @override
  void initState() {
    super.initState();
   // initializeFlutterFire();
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
                  child: DetailsPage(categoryPressed: widget.categoria, localeLoaded: locale,),
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
                  "Loading...",
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
