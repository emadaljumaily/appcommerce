

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/constants.dart';
import 'package:appcommerce/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_form.dart';
import 'dart:async';
class Body extends StatefulWidget {
  String rr;
  Body(this.rr);





  @override
  _OtpScreenState createState() => _OtpScreenState();
}
class _OtpScreenState extends State<Body> {
  String actualCode='';
  String selectedCountry = "+234";

  List<String> country = ["+234", "+1", "+345","+964"];

  String myVerificationId = "";

  //TextEditingController _phone = TextEditingController();
 // TextEditingController _code = TextEditingController();

  bool showClearIcon = false;

  String getCodeText = "Get Code";
  bool isSending = false;
  bool isLoading = false;

  Timer _codeTimer;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
   String _verificationCode='';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              Text("We sent your code to ${widget.rr} "),
              buildTimer(),
              OtpForm('${widget.rr}'),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  // OTP code resend

                },
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa :");
  }





}
