import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'Piatto.dart';

@JsonSerializable()

@JsonSerializable()
class PiattoCategoria {
  String name;
  List<Piatto> listOfItems;

  PiattoCategoria(this.name, this.listOfItems);

  PiattoCategoria.convertFromJson(Map<String, dynamic> json)
      : this.name = json['label'],
        this.listOfItems = createListOfPiatti(json['piatti']);

  static List<Piatto> createListOfPiatti(List<dynamic> tmpDishJson){
    if(tmpDishJson == null)  return new List();
    List<Piatto> listaPiatti = new List();
    tmpDishJson.forEach((element) {
      listaPiatti.add(Piatto.convertFromJson(element));
    });
    return listaPiatti;
  }

  static Piatto createLocaleFromJson(Map<String, dynamic> json) {
    Piatto p = Piatto.convertFromJson(json);
    return p;
  }

  static Map<String, dynamic> createJsonFromPiattoCategoria(PiattoCategoria pc) {
    return {
      'label': pc.name,
      'piatti': PiattoCategoria.createJsonListaPiatti(pc.listOfItems)
    };
  }

  static String createJsonListaPiatti(List<Piatto> piatti) {
    String piattiJson = "[";
    int index = 0;

    for(Piatto p in piatti){
      piattiJson += Piatto.createJsonFromPiatto(p).toString();

      index++;
      if(index < piatti.length) piattiJson += ",";
    }

    piattiJson+="]";
    print("Created json lista piatti list >>> " + piattiJson);
    return piattiJson;
  }

  @override
  String toString() {
    return 'PiattoCategoria{name: $name, listOfItems: $listOfItems}';
  }
}