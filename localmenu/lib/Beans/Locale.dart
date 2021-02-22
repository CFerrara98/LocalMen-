import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Locale {
  String _name;
  int _rate;
  String _city;
  String _address;
  String _iva;
  String _phone;
  int _n_rates;


  Locale(this._name, this._rate, this._city, this._address, this._iva,
      this._phone, this._n_rates);

  Locale.convertFromJson(Map<String, dynamic> json)
      : this._name = json['nome'],
        this._address=json['indirizzo'],
        this._city=json['citta'],
        this._iva=json['partitaiva'],
        this._rate=json['recensione'],
        this._phone=json['telefono'],
        this._n_rates=json['n_recensioni'];

  static Locale createLocaleFromJson(Map<String, dynamic> json) {
  Locale u = Locale.convertFromJson(json);
    return u;
  }


  static Map<String, dynamic> createJsonFromUser(Locale u) {
        return {
        'nome': u._name,
        'indirizzo': u._address,
        'citta': u._city,
        'partitaiva': u._iva,
        'recensione': u._rate,
        'telefono': u._phone,
        'n_recensioni': u._n_rates,
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