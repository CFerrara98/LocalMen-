import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Locale {
  String _name;
  double _rate;
  String _city;
  String _address;
  String _iva;
  String _phone;


  Locale(this._name, this._rate, this._city, this._address, this._iva,
      this._phone);

  Locale.convertFromJson(Map<String, dynamic> json)
      : this._name = json['nome'],
        this._address=json['indirizzo'],
        this._city=json['citta'],
        this._iva=json['partitaiva'],
        this._rate=json['recensione'],
        this._phone=json['telefono'];

  static Locale createUserFromJson(Map<String, dynamic> json) {
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
        };
  }
}

@JsonSerializable()
class LocalePreview {
  String _name;
  double _rate;



  Locale(this._name, this._rate, this._city, this._address, this._iva,
      this._phone);

  Locale.convertFromJson(Map<String, dynamic> json)
      : this._name = json['nome'],
        this._address=json['indirizzo'],
        this._city=json['citta'],
        this._iva=json['partitaiva'],
        this._rate=json['recensione'],
        this._phone=json['telefono'];

  static Locale createUserFromJson(Map<String, dynamic> json) {
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
    };
  }
}