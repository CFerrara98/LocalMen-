import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:localmenu/Beans/CategoriaPiatto.dart';
import 'package:localmenu/Beans/Locale.dart';
import 'package:localmenu/Beans/Piatto.dart';
import 'package:localmenu/Controller/randomizerController.dart';
import 'package:localmenu/Utils/Graphics/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

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
    MediaQueryData mqd = MediaQuery.of(context);

    return Material(
      child: Stack(
        children: [
          Container(
            height: 340,
            decoration: BoxDecoration(
              color: customGrey,
              image: DecorationImage(
                image: coverImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                    children:[
                  Container(
                    height: 300,
                  ),
                  Container(
                    width: mqd.size.width,
                    height: (this.widget.localeLoaded.piattiCategoria.isEmpty) ? 300 : 235 + getContainerSize(this.widget.localeLoaded.piattiCategoria),
                    padding: EdgeInsets.only(bottom: 72),
                    decoration: BoxDecoration(
                      color: customGrey,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32.0),
                          topLeft: Radius.circular(32.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: mqd.size.width,
                          margin: EdgeInsets.only(top: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for(int i = 0; i < this.widget.localeLoaded.rate; i++)
                                Icon(
                                  Icons.star,
                                  size: 20,
                                  color: customOrange,
                                ),
                              Container(
                                margin: EdgeInsets.only(left: 6),
                                child: Text(
                                  "(" + this.widget.localeLoaded.n_rates.toString() + " recensioni)",
                                  style: GoogleFonts.ptSans(
                                    fontSize: 15,
                                    color: customBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: customBlack,
                          height: 20,
                          thickness: 1,
                          indent: mqd.size.width * 23 / 100,
                          endIndent: mqd.size.width * 23 / 100,
                        ),
                        Container(
                          width: mqd.size.width,
                          padding: EdgeInsets.only(left: mqd.size.width * 10 / 100, right: mqd.size.width * 10 / 100),
                          child: AutoSizeText(
                            this.widget.categoryPressed[0].toUpperCase() + this.widget.categoryPressed.substring(1) + // categoria del locale
                                " · " + this.widget.localeLoaded.city,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            minFontSize: 14,
                            style: GoogleFonts.ptSans(
                              fontSize: 20,
                              color: customBlack,
                            ),
                          ),
                        ),
                        Container(
                          width: mqd.size.width,
                          padding: EdgeInsets.only(left: mqd.size.width * 10 / 100, right: mqd.size.width * 10 / 100),
                          margin: EdgeInsets.only(bottom: 24),
                          child: AutoSizeText(
                            "in " + this.widget.localeLoaded.address,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            minFontSize: 14,
                            style: GoogleFonts.ptSans(
                              fontSize: 16,
                              color: customBlack,
                            ),
                          ),
                        ),
                        if (this.widget.localeLoaded.piattiCategoria.isEmpty)
                          Container(
                            padding: EdgeInsets.fromLTRB(mqd.size.width * 8/100, 0, mqd.size.width * 8/100, 0),
                            child: AutoSizeText(
                              "Attualmente questo locale non ha compilato il proprio menù.\nRicontrolla più tardi.",
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              minFontSize: 16,
                              style: GoogleFonts.ptSans(
                                fontSize: 20,
                                color: customBlack,
                              ),
                            ),
                          )
                        else
                          Container(
                            padding: EdgeInsets.fromLTRB(mqd.size.width * 8/100, 0, mqd.size.width * 8/100, 0),
                            // Column that contains all categories
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for(int i = 0; i < this.widget.localeLoaded.piattiCategoria.length; i++)
                                  // Column that contains name and all plates
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 6),
                                        child: AutoSizeText(
                                          this.widget.localeLoaded.piattiCategoria[i].name,
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          minFontSize: 20,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.ptSans(
                                            fontSize: 24,
                                            color: customBlack,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 8),
                                        child: Divider(
                                          endIndent: mqd.size.width * 20/100,
                                          thickness: 1.4,
                                          color: customBlack,
                                          height: 10,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 6),
                                        margin: (i < this.widget.localeLoaded.piattiCategoria.length-1) ? EdgeInsets.only(bottom: 20) : EdgeInsets.only(bottom: 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            for (int j = 0; j < this.widget.localeLoaded.piattiCategoria[i].listOfItems.length; j++)
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: AutoSizeText(
                                                          this.widget.localeLoaded.piattiCategoria[i].listOfItems[j].name,
                                                          textAlign: TextAlign.start,
                                                          maxLines: 1,
                                                          minFontSize: 18,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: GoogleFonts.ptSans(
                                                            fontSize: 20,
                                                            color: customBlack,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(child: Container()),
                                                      Container(
                                                        child: AutoSizeText(
                                                          "€ " + getPriceWithDecimal(this.widget.localeLoaded.piattiCategoria[i].listOfItems[j].price),
                                                          maxLines: 1,
                                                          minFontSize: 18,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: GoogleFonts.ptSans(
                                                            fontSize: 20,
                                                            color: customOrange,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(bottom: 8),
                                                    child: AutoSizeText(
                                                      this.widget.localeLoaded.piattiCategoria[i].listOfItems[j].desc,
                                                      textAlign: TextAlign.start,
                                                      maxLines: 2,
                                                      minFontSize: 12,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 16,
                                                        color: customBlack,
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ]
                ),
                // Orange bar with name
                Column(
                    children:[
                      Container(
                        height: 270,
                      ),
                      Container(
                        width: mqd.size.width * 80 / 100,
                        height: 60,
                        decoration: BoxDecoration(
                          color: customOrange,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Center(
                          // TITLE
                          child: Container(
                            padding: EdgeInsets.only(bottom: 6),
                            child: AutoSizeText(
                              this.widget.localeLoaded.name,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              minFontSize: 20,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.ptSans(
                                fontSize: 32,
                                color: customWhite,
                              ),
                            ),
                          ),
                        )
                      ),
                    ]
                ),
              ],
            ),
          ),
          // Column that contains floating buttons
          Column(
            children:[
              Expanded(child: Container()),
              Container(
                margin: EdgeInsets.only(bottom: 14, right: 16),
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    Container(
                      margin: EdgeInsets.only(right: 12),
                      width: 58,
                      child: RawMaterialButton(
                        onPressed: () async {
                          final url = 'https://www.google.com/maps/search/?api=1&query=' +
                              this.widget.localeLoaded.address + ", " + this.widget.localeLoaded.city;
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            print("Cannot launch url $url");
                          }
                        },
                        elevation: 4.0,
                        fillColor: customOrange,
                        child: Icon(
                          FontAwesomeIcons.mapMarkedAlt,
                          size: 22.0,
                          color: customWhite,
                        ),
                        padding: EdgeInsets.fromLTRB(16.5, 15, 18, 18.5),
                        shape: CircleBorder(),
                      ),
                    ),
                    Container(
                      width: 58,
                      child: RawMaterialButton(
                        onPressed: () {
                          launch("tel://" + this.widget.localeLoaded.phone);
                        },
                        elevation: 4.0,
                        fillColor: customOrange,
                        child: Icon(
                          FontAwesomeIcons.phoneAlt,
                          size: 21.0,
                          color: customWhite,
                        ),
                        padding: EdgeInsets.all(17.0),
                        shape: CircleBorder(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      color: customGrey,
    );
  }

  String getPriceWithDecimal(double price) {
    var f = new NumberFormat("##0.00", "en_US");
    return f.format(price);
  }

  double getContainerSize(List<PiattoCategoria> list) {
    double sizeToReturn = 0;
    for (PiattoCategoria pc in list) {
      sizeToReturn += 67;
      print("found category > actual size: " + sizeToReturn.toString());
      for (Piatto p in pc.listOfItems) {
        sizeToReturn += 55;
        print("found plate > actual size: " + sizeToReturn.toString());
      }
    }
    sizeToReturn-=20;
    return sizeToReturn;
  }

}
