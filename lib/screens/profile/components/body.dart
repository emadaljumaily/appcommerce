
import 'package:appcommerce/localization/languages/languages.dart';
import 'package:appcommerce/localization/locale_constant.dart';
import 'package:appcommerce/models/language_data.dart';
import 'package:appcommerce/screens/profile/det_screen.dart';
import 'package:appcommerce/screens/profile/lang_screen.dart';
import 'package:appcommerce/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../custom_progress_dialog.dart';
import '../../../size_config.dart';
import '../set_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class Body extends StatelessWidget {
  final storage=new FlutterSecureStorage();
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  ProgressDialog _progressDialog=new ProgressDialog();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text:  Languages.of(context).account,
            icon: "assets/icons/User Icon.svg",
            press: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetScreen()))},
          ),
          ProfileMenu(
            text:  Languages.of(context).notification,
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text:  Languages.of(context).setting,
            icon: "assets/icons/Settings.svg",
            press: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context) => SetScreen()))},
          ),
          ProfileMenu(
            text:  Languages.of(context).language,
            icon: "assets/icons/Lang.svg",
           // press: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context) => LangScreen()))},
            press: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LangScreen()));
            //  openAlertBox(context);
            },
          ),
          ProfileMenu(
            text:  Languages.of(context).supportcenter,
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text:  Languages.of(context).singout,
            icon: "assets/icons/Log out.svg",
            press: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text('هل تريد الخروج؟'),
                      actions: [
                        FlatButton(
                          onPressed: () => Navigator.pop(context, false), // passing false
                          child: Text('لا',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            ),

                          ),
                        ),
                        FlatButton(
                          onPressed: () => Navigator.pop(context, true), // passing true
                          child: Text('نعم',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            ),
                          ),

                        ),
                      ],
                    );
                  }).then((exit) {
                if (exit == null) return;

                if (exit) {
                  _progressDialog.showProgressDialog(context,textToBeDisplayed: 'جاري تسجيل الخروج',dismissAfter: Duration(seconds: 2));

                  _progressDialog.dismissProgressDialog(context);
                  if(_progressDialog.isDismissed){
                    _signOut();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInScreen()));
                  }

                } else {
                  // user pressed No button
                }
              });
              /*_signOut();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInScreen()));*/
            },
          ),
        ],
      ),
    );
  }
  openAlertBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: getProportionateScreenWidth(300),
              child: Column(

                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(

                    child:Text(
                      "Language - اللغة",
                      style: TextStyle(fontSize: 24.0),
                    ),

                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Text("select language - اختر اللغة"),
                  SizedBox(
                    height: 5.0,
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: new DropdownButton<LanguageData>(
                        iconSize: 30,
                        hint: Text(Languages.of(context).labelSelectLanguage),
                        onChanged: (LanguageData language) {
                          print(language.languageCode);
                          changeLanguage(context, language.languageCode);
                          // Navigator.of(context).pop();



                        },
                        items: LanguageData.languageList()
                            .map<DropdownMenuItem<LanguageData>>(
                              (e) =>
                              DropdownMenuItem<LanguageData>(
                                value: e,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                     // e.flag,
                                      '',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    Text(e.name)
                                  ],
                                ),
                              ),
                        )
                            .toList(),
                      )
                  ),
                  /* Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Add Review",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),*/
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Container(
                      width: getProportionateScreenWidth(300),
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF0036),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        Languages.of(context).close,
                        style: TextStyle(color: Colors.white,
                            fontSize: 16,
                            fontFamily:"beIN",
                            fontWeight: FontWeight.bold



                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap:(){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
    await facebookSignIn.logOut();
    await storage.delete(key: 'uid');
  }

}
