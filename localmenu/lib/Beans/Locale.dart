import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Locale {
  String _name;
  int _rate;
  String _city;
  String _address;
  String _iva;
  String _phone;
  String _category;

  Locale(this._name, this._rate, this._city, this._address, this._iva,
      this._phone, this._category);
}