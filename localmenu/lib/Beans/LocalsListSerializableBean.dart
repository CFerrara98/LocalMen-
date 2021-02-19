import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localmenu/Beans/Locale.dart';
import 'package:localmenu/Utils/Geolocalizzazione.dart';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class LocalsList{
  String Categoria;
  DateTime time;
  Position cordinate;
  List<LocalePreview> locali;

  initLocalsList(String categoria, List<LocalePreview> locali) async{
    Categoria = categoria;
    this.locali = locali;
    time = DateTime.now();
    cordinate = await Geolocalizzazione.determinePosition();
  }

  addLocale(LocalePreview lc){
    locali.add(lc);
  }

  LocalsList.convertFromJson(Map<String, dynamic> json)
      : this.Categoria = json['Categoria'],
        this.time = json['time'],
        this.cordinate = json['cordinate'],
        this.locali = json['locali'],

  static LocalsList createLocalListFromJson(Map<String, dynamic> json) {
    LocalsList u = LocalsList.convertFromJson(json);
    return u;
  }

  static Map<String, dynamic> createJsonFromUser(LocalsList u) {
    return {
      'Categoria': u.Categoria,
      'time': u.time,
      'cordinate': u.cordinate,
      'locali': u.locali,
    };
  }

}