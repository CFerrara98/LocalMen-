import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class Piatto {
  String name;
  String desc;
  double price;

  Piatto(this.name, this.desc, this.price);

  Piatto.convertFromJson(Map<String, dynamic> json)
      : this.name = json['nome'],
        this.desc = json['ingredienti'],
        this.price = json['prezzo'];

  static Piatto createPiattoFromJson(Map<String, dynamic> json) {
    Piatto p = Piatto.convertFromJson(json);
    return p;
  }

  static Map<String, dynamic> createJsonFromPiatto(Piatto p) {
    return {
      'nome': p.name,
      'ingredienti': p.desc,
      'prezzo': p.price
    };
  }

  @override
  String toString() {
    return 'Piatto{name: $name, desc: $desc, price: $price}';
  }
}