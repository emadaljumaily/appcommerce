

import 'package:flutter/material.dart';

class Dataj {
  String id,title,description,rating;
  //List<String>image;
  int price;
  dynamic image = new List<String>();
  dynamic colors = new List<int>();
  dynamic size = new List<String>();
  final bool isFavourite, isPopular;
  String type;



  Dataj(
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
      this.type

        );


}