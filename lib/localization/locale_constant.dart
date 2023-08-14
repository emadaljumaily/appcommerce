import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


const String prefSelectedLanguageCode = "SelectedLanguageCode";
final storage=new FlutterSecureStorage();
Future<Locale> setLocale(String languageCode) async {
  //SharedPreferences _prefs = await SharedPreferences.getInstance();
  await storage.write(key:prefSelectedLanguageCode, value:languageCode);
  //await _prefs.setString(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  //String languageCode="";
  //SharedPreferences _prefs = await SharedPreferences.getInstance();
 // String languageCodee = _prefs.getString(prefSelectedLanguageCode) ?? "en";
  String languageCode=await storage.read(key:prefSelectedLanguageCode) ?? "ar";
  /*await storage.read(key:prefSelectedLanguageCode).then((value){
    languageCode=value;
  })?? "en";*/
  print("local_language : ${languageCode}");
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode != null && languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : Locale('ar', '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  var _locale = await setLocale(selectedLanguageCode);
  MyApp.setLocale(context, _locale);
}