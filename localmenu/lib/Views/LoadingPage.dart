import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localmenu/Beans/Locale.dart';
import 'package:localmenu/Controller/controllerLocale.dart';
import 'package:localmenu/Controller/randomizerController.dart';
import 'package:localmenu/Utils/custom_bordered_text.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Utils/Graphics/colors.dart';
import 'detailspage.dart';

class MiddleLoading extends StatefulWidget {

  final LocalePreview l ;
  final String categoria;

  const MiddleLoading ({ Key key, @required this.l, @required this.categoria }): super(key: key);

  @override
  _MiddleLoadingState createState() => _MiddleLoadingState();

}

class _MiddleLoadingState extends State<MiddleLoading> {

  Locale locale = null;

  @override
  void initState() {
    super.initState();
    initializeLocale();
  }

  void initializeLocale() async {
    
    locale = await ControllerLocale.getLocaleFromPreview(widget.l, widget.categoria);

    if (locale != null)
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
                  child: DetailsPage(categoryPressed: widget.categoria, localeLoaded: locale,),
                  duration: Duration(milliseconds: 800),
                )
            );
          },
      );
    else {
      Fluttertoast.showToast(
          msg: "Errore di caricamento...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Navigator.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {

    MediaQueryData mqd = MediaQuery.of(context);

    return Scaffold(
      body: Material(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: RandomizerController.getLoadingImage(this.widget.categoria),
                fit: BoxFit.cover,
              )
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(mqd.size.width * 12 / 100, 0, mqd.size.width * 12 / 100, 0),
            child: Column(
              children: [
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: BorderedText(
                    strokeColor: Colors.black,
                    strokeWidth: 5,
                    strokeCap: StrokeCap.round,
                    child: AutoSizeText(
                      this.widget.categoria[0].toUpperCase() + this.widget.categoria.substring(1),
                      maxLines: 1,
                      style: GoogleFonts.ptSans(
                        fontSize: 28,
                        color: customWhite,
                      ),
                    ),
                  ),
                ),
                BorderedText(
                  strokeColor: Colors.black,
                  strokeWidth: 6,
                  child: AutoSizeText(
                    this.widget.l.getName(),
                    maxLines: 2,
                    minFontSize: 26,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ptSans(
                      fontSize: 36,
                      color: customWhite,
                      height: 1.05,
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
