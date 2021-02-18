import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Color changeColorHue(Color color, newHueValue) =>
    HSLColor.fromColor(color).withHue(newHueValue).toColor();

Color changeColorSaturation(Color color, newSaturationValue) =>
    HSLColor.fromColor(color).withSaturation(newSaturationValue).toColor();

Color changeColorLightness(Color color, newLightnessValue) =>
    HSLColor.fromColor(color).withLightness(newLightnessValue).toColor();

Color customWhite = HexColor('#ffffff');
Color customPerlWhite = HexColor('#F7F7F7');

Color customBlackGrey = HexColor('#808080');
Color customLightGrey = HexColor('#dedcdc');

Color customBlackBlue = HexColor('#323750');

//Color customViolet = HexColor('#4945fc');
Color customVioletDeSat = HexColor('#7E7CFC');
Color customViolet = customVioletDeSat;

//Color customBlue = HexColor('##4844FB');
Color customBlueDeSat = HexColor('#7D7AFA');
Color customBlue = customBlueDeSat;

//Color customPink = HexColor('#fd4488');
Color customPinkNavigation =
    HexColor('#FC7CAB'); //Color.fromARGB(255, 255, 125, 173);
Color customPink = customPinkNavigation;

//Color customPink = HexColor('#fd4488');
Color customColorTrash =
HexColor('#f6f6f6'); //Color.fromARGB(255, 255, 125, 173);

TextStyle basefont =
    GoogleFonts.montserrat(); //TextStyle(fontFamily: 'Montserrat_ExtraLight');

/*
{
  FontWeight.w100: 'Thin',
  FontWeight.w200: 'ExtraLight',
  FontWeight.w300: 'Light',
  FontWeight.w400: 'Regular',
  FontWeight.w500: 'Medium',
  FontWeight.w600: 'SemiBold',
  FontWeight.w700: 'Bold',
  FontWeight.w800: 'ExtraBold',
  FontWeight.w900: 'Black',
}
*/

