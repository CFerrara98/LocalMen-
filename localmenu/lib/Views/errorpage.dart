import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localmenu/Utils/Graphics/colors.dart';

class ConnectionErrorPage extends StatefulWidget {
  @override
  _ConnectionErrorPageState createState() => _ConnectionErrorPageState();
}

class _ConnectionErrorPageState extends State<ConnectionErrorPage> {

  Future<bool> onBackPressed() async {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {

    MediaQueryData mqd = MediaQuery.of(context);

    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        body: Material(
          child: Container(
            width: mqd.size.width,
            height: mqd.size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(left: mqd.size.width * 18 / 100, right: mqd.size.width * 18 / 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Container()),
                  AutoSizeText(
                    "Errore di connessione.\nControlla che la connessione dati o il Wi-Fi sia attivo, quindi riavvia l'applicazione e riprova.",
                    maxLines: 8,
                    minFontSize: 16,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: customBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
