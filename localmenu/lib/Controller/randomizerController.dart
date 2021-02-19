import 'dart:math';

import 'package:flutter/material.dart';

class RandomizerController {

  static AssetImage getRandomCardImage(String category) {

    Random random = new Random();
    int randomNumber = random.nextInt(10); // 0 <= randomNumber <= 9

    if (category.toLowerCase() == "ristorante") {

    }
    if (category.toLowerCase() == "pizzeria"){

    }
    if (category.toLowerCase() == "paninoteca"){

    }
    if (category.toLowerCase() == "sushi") {

    }

  }

}