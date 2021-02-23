import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Locale {
  String name;
  int rate;
  String city;
  String address;
  String iva;
  String phone;
  int n_rates;


  Locale(this.name, this.rate, this.city, this.address, this.iva,
      this.phone, this.n_rates);

  Locale.convertFromJson(Map<String, dynamic> json)
      : this.name = json['nome'],
        this.address=json['indirizzo'],
        this.city=json['citta'],
        this.iva=json['partitaiva'],
        this.rate=json['recensione'],
        this.phone=json['telefono'],
        this.n_rates=json['n_recensioni'];

  static Locale createLocaleFromJson(Map<String, dynamic> json) {
  Locale u = Locale.convertFromJson(json);
    return u;
  }


  static Map<String, dynamic> createJsonFromUser(Locale u) {
        return {
        'nome': u.name,
        'indirizzo': u.address,
        'citta': u.city,
        'partitaiva': u.iva,
        'recensione': u.rate,
        'telefono': u.phone,
        'n_recensioni': u.n_rates,
        };
  }
}

@JsonSerializable()
class LocalePreview {
  String _name;
  double _rate;
  String _city;


  LocalePreview(this._name, this._rate, this._city);

  String getName(){
    return _name;
  }

  int getRate() {
    return _rate.round();
  }


  String get city => _city;

  LocalePreview.convertFromJson(Map<String, dynamic> json)
      : this._name = json['nome'],
        this._city = json['citta'],
        this._rate = double.parse(json['recensione']);

  static LocalePreview createLocalePreviewFromJson(Map<String, dynamic> json) {
    LocalePreview u = LocalePreview.convertFromJson(json);
    return u;
  }

  static List<LocalePreview> createListLocaliPreviewFromJson(String listJson){
    List<LocalePreview> l = new List();
    List<dynamic> myMap = json.decode(listJson);
    print(myMap);

    myMap.forEach((element) {
      l.add(LocalePreview.convertFromJson(element));
    });

    return l;
  }

  @override
  String toString() {
    return 'LocalePreview{_name: $_name, _rate: $_rate, _city: $_city}';
  }

  static Map<String, dynamic> createJsonFromUser(LocalePreview u) {
    return {
      'nome': u._name,
      'recensione': u._rate,
      'citta': u._city
    };
  }
}

@JsonSerializable()
class Piatto {
  String _name;
  String _desc;
  double _price;
}

@JsonSerializable()
class PiattoCategoria {
  String _name;
  List<Piatto> _listOfItems;
}