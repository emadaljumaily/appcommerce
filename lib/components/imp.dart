import 'package:flutter/material.dart';

class LogProvider extends ChangeNotifier{

  String msg;
  String  get aa =>
      this.msg;

  set aa(String s){
    msg=s;
    notifyListeners();
  }



}