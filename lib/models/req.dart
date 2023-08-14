import 'package:flutter/material.dart';

class Req{
  String title,image,date;
  int price,number;
  dynamic color = new List<int>();
  dynamic size = new List<String>();

      // colorr  = Color(color).withOpacity(1);
  Req(this.title,this.image,this.date,this.price,this.number,this.color,this.size);
}