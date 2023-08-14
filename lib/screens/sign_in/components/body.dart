import 'package:appcommerce/components/socal_card.dart';
import 'package:appcommerce/localization/languages/languages.dart';
import 'package:appcommerce/screens/home/home_screen.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:appcommerce/screens/sign_in/google/service.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/components/no_account_text.dart';
import '../../../size_config.dart';
import 'sign_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class Body extends StatelessWidget {
  final storage=new FlutterSecureStorage();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String _message = 'Log in/out by pressing the buttons below.';
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Text(
                  Languages.of(context).welcome,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                      fontFamily: "beIN"
                  ),
                ),

                Text(
                  Languages.of(context).descript,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: "beIN"),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () async {
                        //Navigator.pushNamed(context, GoogleSignIn.routeName);
                        FirebaseService service = new FirebaseService();
                        try {
                          await service.signInwithGoogle();
                          Navigator.pushNamed(context, HomeScreen.routeName);
                        } catch (e) {
                          print(e);
                          /*if (e is FirebaseAuthException) {
              showMessage(e.message);
            }*/
                        }
                      },
                    ),
                    SocalCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () async {
                        FirebaseService service = new FirebaseService();
                        try {
                          await service.signInFacebook();
                        Navigator.pushNamed(context, HomeScreen.routeName);
                        } catch (e) {
                          print(e);
                          /*if (e is FirebaseAuthException) {
              showMessage(e.message);
            }*/
                        }

                      },
                    ),

                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }




}


