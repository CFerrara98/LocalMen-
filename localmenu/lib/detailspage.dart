import 'package:flutter/material.dart';
import 'package:localmenu/Beans/Locale.dart';
import 'package:localmenu/Controller/randomizerController.dart';
import 'package:localmenu/Utils/Graphics/colors.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();

  final String categoryPressed;
  final Locale localeLoaded;
  const DetailsPage ({ Key key, @required this.categoryPressed, @required this.localeLoaded }): super(key: key);

}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            height: 200,
            color: customBlack,
            child: Image(
              image: RandomizerController.getRandomCardImage(this.widget.categoryPressed),

            ),
          ),

        ]
      ),
      color: customBlack,
    );
  }
}
