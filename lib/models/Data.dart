

import 'package:flutter/material.dart';

class Dataa {
  String id,title,description,rating;
  int price;
  dynamic image = new List<String>();
  dynamic colors = new List<int>();
  dynamic size = new List<String>();
   bool isFavourite, isPopular;
String type;



  Dataa(
    this.id,
    this.title,
    this.description,
    this.image,
    this.colors,
    this.price,
    this.size,
    this.rating,
    this.isFavourite,
    this.isPopular,
      this.type,

        );


}