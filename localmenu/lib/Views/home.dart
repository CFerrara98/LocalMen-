
import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:localmenu/Beans/Locale.dart';
import 'package:localmenu/Beans/LocalsListSerializableBean.dart';
import 'package:localmenu/Controller/controllerLocale.dart';
import 'package:localmenu/Controller/randomizerController.dart';
import 'package:localmenu/Utils/Geolocalizzazione.dart';
import 'package:localmenu/Utils/Graphics/colors.dart';
import 'package:localmenu/Utils/exceptions.dart';
import 'package:localmenu/Views/LoadingPage.dart';
import 'package:localmenu/Views/errorpage.dart';
import 'package:page_transition/page_transition.dart';

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
  String chosenCategory;
  bool canLoad = false;

  @override
  void initState() {
    super.initState();
    preload();
    categoryCards = new List<CategoryCard>();
    categoryCards.add(new CategoryCard("Ristorante", AssetImage("images/022-serving-dish.png")));
    categoryCards.add(new CategoryCard("Pizzeria", AssetImage("images/023-pizza-slice.png")));
    categoryCards.add(new CategoryCard("Paninoteca", AssetImage("images/010-burger.png")));
    categoryCards.add(new CategoryCard("Sushi", AssetImage("images/003-chinese-food.png")));
    previewList = new List();
  }

  void preload() async {
    await checkInternetConnection();
    await failureRedirect();
  }

  Future checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        canLoad = true;
      }
    } on SocketException catch (_) {
      canLoad = false;
    }
  }

  Future failureRedirect() async {
    if (!canLoad) {
      Timer(
          Duration(
            seconds: 1,
          ),
          // CALLBACK
              () {
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: ConnectionErrorPage(),
                  duration: Duration(milliseconds: 800),
                )
            );
          }
      );
    }
  }

  Future<bool> onBackPressed() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Esci'),
        content: new Text('Sei sicuro di voler uscire?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => SystemNavigator.pop(),
            child: new Text('Si'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {

    double cardWidth = 220;
    double cardHeight = 145;

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
                )
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(22, 42, 22, 12),
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
                                if (!isLoading && activeIndex != index) {
                                  setState(() {
                                    isLoading = true;
                                    activeIndex = index;
                                    hasCategoryChosen = true;
                                    chosenCategory = categoryCards[index].name.toLowerCase();
                                  });
                                  if (previewList.isNotEmpty) previewList = new List();

                                  try {
                                    // Checking if locals are already saved in local device
                                    LocalsList localList = await ControllerLocale.getLocalsPreviewList(categoryCards[index].name.toLowerCase());

                                    // A list already exists on phone, so we must check if the list needs an update
                                    if (localList != null){
                                      Position p =  await Geolocalizzazione.determinePosition();
                                      if ((p.latitude - localList.coordinate.latitude).abs() > 1) localList = null;
                                      else if ((p.longitude - localList.coordinate.longitude).abs() > 1) localList = null;
                                      else if (DateTime.now().difference(new DateFormat("yyyy-MM-dd").parse(localList.time.replaceAll('\"', ''))).inDays > 7) localList = null;
                                    }

                                    if (localList == null) {
                                      // Locals not saved on phone
                                      print("SAVING ON PHONE CATEGORY " + categoryCards[index].name.toLowerCase());
                                      databaseStream = await ControllerLocale.initLocaliFromCategory(categoryCards[index].name, 13000); // DEBUG RANGE HERE
                                      databaseStream.listen((event) {
                                        event.forEach((element) {
                                          LocalePreview lp = LocalePreview.createLocalePreviewFromJson(element.data());
                                          if (lp.isAllowed) previewList.add(lp);
                                        });
                                        ControllerLocale.saveLocalsPreviewList(categoryCards[index].name.toLowerCase(), previewList);
                                        setState(() {
                                          isLoading = false;
                                        });
                                      });
                                    } else {
                                      // Locals already saved
                                      print("LOADING FROM PHONE CATEGORY " + categoryCards[index].name.toLowerCase());
                                      print(localList.locali.toString());
                                      for (LocalePreview lp in localList.locali) {
                                        previewList.add(lp);
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  } on GeoException catch (gexc) {
                                    setState(() {
                                      isLoading = false;
                                      activeIndex = -1;
                                      hasCategoryChosen = false;
                                    });
                                    Fluttertoast.showToast(
                                      msg: gexc.toString(),
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: customBlack,
                                      textColor: customWhite,
                                      fontSize: 16.0,
                                    );
                                  }

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
                        height: cardHeight,
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
                            /*
                            *     CARDS GOES HERE
                            * */
                            (previewList.length > 0) ?
                              ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: previewList.length, // TEMP
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: cardWidth,
                                    height: cardHeight,
                                    margin: (index < previewList.length-1) ? EdgeInsets.only(right: 20) : EdgeInsets.only(right: 0),
                                    child: FlatButton(
                                      onPressed: () {
                                        onCardPressed(chosenCategory, previewList[index], context);
                                      },
                                      padding: EdgeInsets.zero,
                                      child: Stack(
                                        children: [
                                          // Container background
                                          Container(
                                            padding: EdgeInsets.only(top: 20), // edit here to change description size
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                                color: customBlack,
                                              ),
                                            ),
                                            width: cardWidth,
                                            height: cardHeight,
                                          ),
                                          // Container grey border
                                          Container(
                                            padding: EdgeInsets.only(left: ((cardWidth-52)/8)/2), // code to center the image, don't touch it
                                            child: Container(
                                              width: cardWidth - ((cardWidth-52)/8),
                                              height: cardHeight - ((cardHeight-8)/2.5), // edit here to change image size
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                                color: customGrey,
                                              ),
                                            ),
                                          ),
                                          // Container with image
                                          Container(
                                            padding: EdgeInsets.only(left: (cardWidth/8)/2), // code to center the image, don't touch it
                                            child: Container(
                                              width: cardWidth - (cardWidth/8),
                                              height: cardHeight - (cardHeight/2.5), // edit here to change image size
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(24)),
                                                color: customGrey,
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(16),
                                                child: Image(
                                                  image: RandomizerController.getRandomCardImage(chosenCategory),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: cardHeight / 1.52, left: 12, right: 12),
                                            width: cardWidth - 24,
                                            child: AutoSizeText(
                                              previewList[index].getName(),
                                              maxLines: 1,
                                              minFontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.ptSans(
                                                fontSize: 20,
                                                color: customWhite,
                                              ),
                                            )
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: cardHeight / 1.18),
                                              width: cardWidth,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  for (int i = 1; i <= 5; i++)
                                                    if (i <= previewList[index].getRate())
                                                      Icon(
                                                        Icons.star,
                                                        size: 14,
                                                        color: customOrange,
                                                      )
                                                    else
                                                      Icon(
                                                        Icons.star,
                                                        size: 14,
                                                        color: customWhite,
                                                      ),
                                                ],
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              )
                            /*
                            *     END OF CARDS SECTION
                            * */
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
      ),
    );

  }

  void onCardPressed(String category, LocalePreview l, BuildContext ctx) {
    Navigator.push(
        ctx,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: MiddleLoading(l: l, categoria: category),
          duration: Duration(milliseconds: 600),
        )
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
