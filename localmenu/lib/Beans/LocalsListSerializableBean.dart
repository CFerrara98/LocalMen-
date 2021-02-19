import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localmenu/Beans/Locale.dart';
import 'package:localmenu/Utils/Geolocalizzazione.dart';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class LocalsList{
  String Categoria;
  DateTime time;
  Position coordinate;
  List<LocalePreview> locali;

  LocalsList();

  static Future<LocalsList> initLocalsList(String categoria, List<LocalePreview> locali) async{
    LocalsList l = new LocalsList();

    l.Categoria = categoria;
    l.locali = locali;
    l.time = DateTime.now();
    l.coordinate = await Geolocalizzazione.determinePosition();

    return l;
  }

  addLocale(LocalePreview lc){
    locali.add(lc);
  }

  LocalsList.convertFromJson(Map<String, dynamic> json)
      : this.Categoria = json['Categoria'],
        this.time = json['time'],
        this.coordinate = json['cordinate'],
        this.locali = json['locali'];

  static LocalsList createLocalListFromJson(Map<String, dynamic> json) {
    LocalsList u = LocalsList.convertFromJson(json);
    return u;
  }

  static Map<String, dynamic> createJsonFromUser(LocalsList u) {
    return {
      'Categoria': u.Categoria,
      'time': u.time,
      'cordinate': u.coordinate,
      'locali': u.locali,
    };
  }

}