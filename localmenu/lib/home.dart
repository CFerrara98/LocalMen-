import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localmenu/Beans/Locale.dart';

import 'Controller/controllerLocale.dart';
import 'Utils/Graphics/colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int activeIndex = -1;
  List<CategoryCard> categoryCards;
  List<LocalePreview> previewList;
  bool hasCategoryChosen = false;
  bool isLoading = false;
  Stream databaseStream;

  @override
  void initState() {
    super.initState();
    categoryCards = new List<CategoryCard>();
    categoryCards.add(new CategoryCard("Ristorante", AssetImage("images/022-serving-dish.png")));
    categoryCards.add(new CategoryCard("Pizzeria", AssetImage("images/023-pizza-slice.png")));
    categoryCards.add(new CategoryCard("Paninoteca", AssetImage("images/010-burger.png")));
    categoryCards.add(new CategoryCard("Sushi", AssetImage("images/003-chinese-food.png")));
    previewList = new List();
  }

  @override
  Widget build(BuildContext context) {

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
            padding: EdgeInsets.fromLTRB(22, 24, 22, 12),
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
                            onTap: () async {
                              if (!isLoading) {
                                setState(() {
                                  isLoading = true;
                                });
                                if (activeIndex != index)
                                  setState(() {
                                    activeIndex = index;
                                    hasCategoryChosen = true;
                                  });
                                if (previewList.isNotEmpty) previewList = new List();
                                databaseStream = await ControllerLocale.initLocaliFromCategory(categoryCards[index].name, 100000);
                                databaseStream.listen((event) {
                                  event.forEach((element) {
                                    previewList.add(LocalePreview.createLocalePreviewFromJson(element.data()));
                                  });
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              }
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
                    Container(
                      height: 135,
                      margin: EdgeInsets.only(top: 14),
                      child:
                          // # IF1
                        (hasCategoryChosen) ?
                            // # IF2 < IF1
                          (isLoading) ?
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage("images/update-arrows.png"),
                                  color: customBlack,
                                  height: 95,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: AutoSizeText(
                                      "Attendi un istante.\nSto cercando i locali.",
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.ptSans(
                                        fontSize: 20,
                                        color: customBlack,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : // ELSE2
                            // IF3 < IF2
                          (previewList.length > 0) ?
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: previewList.length, // TEMP
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: 185,
                                  height: 135,
                                  margin: EdgeInsets.only(right: 12), // TEMP
                                  child: FlatButton(
                                    onPressed: () {
                                      print("Pressed item"); // TEMP
                                    },
                                    padding: EdgeInsets.zero,
                                    child: Container(),
                                  ),
                                  color: customOrange,
                                );
                              }
                            )
                          : // ELSE3
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage("images/034-waiter.png"),
                                    color: customBlack,
                                    height: 95,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: AutoSizeText(
                                        "Non ci sono locali attorno a te.\nRicontrolla tra qualche giorno.",
                                        maxLines: 3,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.ptSans(
                                          fontSize: 20,
                                          color: customBlack,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        : // ELSE1
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage("images/047-menu.png"),
                                color: customBlack,
                                height: 95,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: AutoSizeText(
                                    "Clicca una categoria per visualizzare i locali disponibili intorno a te",
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ptSans(
                                      fontSize: 20,
                                      color: customBlack,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
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
