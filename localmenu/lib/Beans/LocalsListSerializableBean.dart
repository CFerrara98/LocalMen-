import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localmenu/Beans/Locale.dart';
import 'package:localmenu/Utils/Geolocalizzazione.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';


@JsonSerializable()
class LocalsList{
  String Categoria;
  DateTime time;
  Position coordinate;
  List<LocalePreview> locali;
  //static var formatter = DateFormat('dd MM yyyy');

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
        this.time = DateTime.parse(json['time']),
        this.coordinate =Position.fromMap(json['cordinate']) ,
        this.locali = LocalePreview.createListLocaliPreviewFromJson(json['locali']) ;

  static LocalsList createLocalListFromJson(Map<String, dynamic> json) {

    LocalsList u = LocalsList.convertFromJson(json);
    return u;
  }

  static Map<String, dynamic> createJsonFromUser(LocalsList u) {
    return {
      'Categoria': u.Categoria,
      'time': u.time.toString(),
      'cordinate': u.coordinate,
      'locali': u.locali,
    };
  }

}
