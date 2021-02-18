import 'package:flutter/material.dart';

import 'Controller/controllerLocale.dart';
import 'Utils/Graphics/colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    ControllerLocale.initLocaliFromCategory("Ristorante");

    return Container(
      color: customWhite,
      child: Text("Hello world"),
    );
  }
}
