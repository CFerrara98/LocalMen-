import 'dart:math';

import 'package:flutter/material.dart';

class RandomizerController {

  static int _prevNumber = -1;

  static AssetImage getRandomCardImage(String category) {

    // Random image ID generator
    Random random = new Random();
    int randomNumber; // 0 <= randomNumber <= 9
    do
      randomNumber = random.nextInt(10);
    while (randomNumber == _prevNumber);
    _prevNumber = randomNumber;

    AssetImage toReturn;
    print("Trying to get image at path images/" + category.toLowerCase() + "/" + (randomNumber + 1).toString() + ".png");

    if (category.toLowerCase() == "ristorante") {
      toReturn = AssetImage("images/ristorante/" + (randomNumber + 1).toString() + ".png");
    } else if (category.toLowerCase() == "pizzeria"){
      toReturn = AssetImage("images/pizzeria/" + (randomNumber + 1).toString() + ".png");
    } else if (category.toLowerCase() == "paninoteca"){
      toReturn = AssetImage("images/paninoteca/" + (randomNumber + 1).toString() + ".png");
    } else if (category.toLowerCase() == "sushi") {
      toReturn = AssetImage("images/sushi/" + (randomNumber + 1).toString() + ".png");
    }

    return toReturn;

  }

}