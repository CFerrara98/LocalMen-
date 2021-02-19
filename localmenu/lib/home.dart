import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Controller/controllerLocale.dart';
import 'Utils/Graphics/colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int activeIndex = -1;
  List<CategoryCard> categoryCards;

  @override
  void initState() {
    super.initState();
    categoryCards = new List<CategoryCard>();
    categoryCards.add(new CategoryCard("Ristorante", AssetImage("images/022-serving-dish.png")));
    categoryCards.add(new CategoryCard("Pizzeria", AssetImage("images/023-pizza-slice.png")));
    categoryCards.add(new CategoryCard("Paninoteca", AssetImage("images/010-burger.png")));
    categoryCards.add(new CategoryCard("Sushi", AssetImage("images/003-chinese-food.png")));
  }


  @override
  Widget build(BuildContext context) {

    // Code to debug
    var locali = ControllerLocale.initLocaliFromCategory("Pizzeria", 10000);


    MediaQueryData mqd = MediaQuery.of(context);

    return Scaffold(
      body: Material(
        child: Container(
          width: mqd.size.width,
          height: mqd.size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.png'),
                fit: BoxFit.cover,
              )
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
            height: mqd.size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // COLUMN THAT CONTAINS TITLE AND DESCRIPTION

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Bentornato",
                      maxLines: 1,
                      minFontSize: 14,
                      style: GoogleFonts.ptSans(
                        fontSize: 48,
                        color: customBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AutoSizeText(
                      "Vediamo cosa offre il tuo locale preferito",
                      maxLines: 1,
                      minFontSize: 14,
                      style: GoogleFonts.ptSans(
                        fontSize: 48,
                        color: customBlack,
                      ),
                    ),
                  ],
                ),

                // COLUMN THAT CONTAINS CATEGORY CARDS

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Categorie",
                      maxLines: 1,
                      minFontSize: 14,
                      style: GoogleFonts.ptSans(
                        fontSize: 28,
                        color: customBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      child: GridView.builder(
                        padding: EdgeInsets.only(top: 14),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2/1.2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 16,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                color: (index != activeIndex) ? customGrey : customOrange,
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                              ),child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 6),
                                    child: Image(
                                      image: categoryCards[index].icon,
                                      width: 50,
                                      height: 50,
                                      color: (index != activeIndex) ? customBlack : customWhite,
                                    ),
                                  ),
                                  AutoSizeText(
                                    categoryCards[index].name,
                                    minFontSize: 12,
                                    maxLines: 1,
                                    style: GoogleFonts.ptSans(
                                      fontSize: 18,
                                      color: (index != activeIndex) ? customBlack : customWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                print("Pressed " + categoryCards[index].name);
                                activeIndex = index;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),

                // COLUMN THAT CONTAINS CARDS OF THE CHOSEN CATEGORY

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Locali",
                      maxLines: 1,
                      minFontSize: 14,
                      style: GoogleFonts.ptSans(
                        fontSize: 28,
                        color: customBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    /*
                    *
                    *   ADD HERE THE HORIZONTAL CARDS' LIST
                    *
                    * */
                  ],
                ),
              ],
            ),
          )
        ),
      ),
    );

  }
}

class CategoryCard {
  String name;
  AssetImage icon;
  CategoryCard(String name, AssetImage icon) {
    this.name = name;
    this.icon = icon;
  }
}
