import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localmenu/Beans/Locale.dart';
import 'package:localmenu/Utils/Geolocalizzazione.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';


@JsonSerializable()
class LocalsList{
  String Categoria;
  String time;
  Position coordinate;
  List<LocalePreview> locali;
  //static var formatter = DateFormat('dd MM yyyy');

  LocalsList();

  static Future<LocalsList> initLocalsList(String categoria, List<LocalePreview> locali) async{
    LocalsList l = new LocalsList();

    l.Categoria = categoria;
    l.locali = locali;
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(now);
    l.time = formatted;
    l.coordinate = await Geolocalizzazione.determinePosition();

    return l;
  }

  addLocale(LocalePreview lc){
    locali.add(lc);
  }

  LocalsList.convertFromJson(Map<String, dynamic> json, double latitude, double longitude)
      : this.Categoria = json['Categoria'],
        this.time = json['time'],
        this.coordinate = new Position(latitude: latitude, longitude: longitude),
        this.locali = LocalePreview.createListLocaliPreviewFromJson(json['locali']);

  static LocalsList createLocalListFromJson(Map<String, dynamic> json) {
    String jsonCoordinate = json["cordinate"];
    var jsonTranslated = jsonDecode(jsonCoordinate);
    LocalsList l = LocalsList.convertFromJson(json, jsonTranslated["latitude"], jsonTranslated["longitude"]);
    return l;
  }

  static Map<String, dynamic> createJsonFromLocalePreview(LocalsList u) {
    String localiJson = "[";
    int index = 0;
    for (LocalePreview lp in u.locali) {
      localiJson += "{\"nome\":\"" + lp.getName() + "\", \"recensione\":\"" + lp.getRate().toString() + "\", \"citta\":\"" + lp.city +
          "\", \"is_allowed\":\"" + lp.isAllowed + "\"}";
      if (index < u.locali.length-1) localiJson += ",";
      index++;
    }
    localiJson+="]";
    print("Created json locali list >>> " + localiJson);
    return {
      'Categoria': u.Categoria,
      'time': "\"" + u.time + "\"",
      'cordinate': "{\"latitude\":\"" + u.coordinate.latitude.toString() + "\", \"longitude\":\"" + u.coordinate.longitude.toString() + "\"}",
      'locali': localiJson,
    };
  }

}
