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

    AssetImage coverImage = RandomizerController.getRandomCardImage(this.widget.categoryPressed);

    return Material(
      child: Stack(
        children: [
          Container(
            height: 340,
            decoration: BoxDecoration(
              color: customBlack,
              image: DecorationImage(
                image: coverImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
                children:[
              Container(
                height: 300,
              ),
              Container(
                height: 800,
                decoration: BoxDecoration(
                  color: customWhite,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32.0),
                      topLeft: Radius.circular(32.0),
                  ),
                ),
              ),
            ]
            ),
          ),
        ],
      ),
      color: customBlack,
    );
  }

}
