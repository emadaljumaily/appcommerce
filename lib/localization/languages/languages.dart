import 'package:flutter/material.dart';

abstract class Languages {

  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;

  String get labelWelcome;

  String get labelInfo;

  String get labelSelectLanguage;
  //------------Splash screen----------------//
  @override
  String get text1;
  @override
  String get text2;
  @override
  String get text3;
  //-------------sign in,sign up----------------//
  @override
  String get welcome;
  @override
  String get descript;
  @override
  String get email;
  @override
  String get password;
  @override
  String get repassword;
  @override
  String get remember;
  @override
  String get forget;
  @override
  String get nohaveacount ;
  @override
  String get create ;
  @override
  String get signin ;

  @override
  String get createacount;
  @override
  String get descriptcreateaccount;
//-------------Compelete profile----------------//
  @override
  String get descriptcomplete;
  @override
  String get accountinfo;
  @override
  String get descript_complete;
  @override
  String get button_complete;
  @override
  String get fullname ;
  @override
  String get address;
  @override
  String get addresstitle;
  @override
  String get contry ;
  @override
  String get phone;
  @override
  String get newpass;
  @override
  String get newnumber;
//-------------Forget Password----------------//
  @override
  String get welcomeforget ;
  @override
  String get descriptforget ;
  @override
  String get emailforget ;
  @override
  String get send ;
//----------Profile Menu--------------//
  String get account;
  String get notification;
  String get setting;
  String get language;
  String get supportcenter;
  String get singout;
  String get lang;
  String get langselect;
  String get btnlang;
  String get btnphonechange;
  String get btnchangepass;

  //----------other --------------//
  String get cart;
  String get size;
  String get color;
  String get buy;
  String get close;

}