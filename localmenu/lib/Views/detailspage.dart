import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localmenu/Beans/Locale.dart';
import 'package:localmenu/Controller/randomizerController.dart';
import 'package:localmenu/Utils/Graphics/colors.dart';
import 'package:url_launcher/url_launcher.dart';

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
              color: customBlack,
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
                    height: 800, // TEMP HERE: must calculate with category list
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
                        )
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
      color: customBlack,
    );
  }

}
