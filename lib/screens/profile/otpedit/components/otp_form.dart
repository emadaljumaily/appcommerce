import 'package:appcommerce/screens/home/home_screen.dart';
import 'package:appcommerce/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/components/default_button.dart';
import 'package:appcommerce/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../constants.dart';
import 'package:firebase_database/firebase_database.dart';


class OtpForm extends StatefulWidget {
String s;
   OtpForm(this.s,  {
    Key key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String name;
  String lname;
  String adres;

  bool isLoading = false;
  String status='';
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;
  final n1 = new TextEditingController();
  final n2 = new TextEditingController();
  final n3 = new TextEditingController();
  final n4 = new TextEditingController();
  final n5 = new TextEditingController();
  final n6 = new TextEditingController();

  String myVerificationId = "";
  Future<String> getUIDD() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    //final uid=user.uid;
    final db = FirebaseDatabase.instance.reference().child("Users/"+user.uid);
    db.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        name=values["FirstName"];
        lname=values["LastName"];
        adres=values["Address"];
        print(values["Email"]);
      });
    });
  }
  Future<String> getdata() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;

    final db =await FirebaseDatabase.instance.reference().child("Users/${uid}/");

    db.once().then((DataSnapshot snapshot) {
      //print('Data : ${snapshot.value}');
      print('uuuuu : ${snapshot.value['id']}');
      name=snapshot.value['FirstName'];
      lname=snapshot.value['LastName'];
      adres=snapshot.value['Address'];
    });
  }
  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
    print('mmmmmmmmmmmmmmmm${widget.s}');
    getdata();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  controller: n1,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  controller: n2,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin3FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  controller: n3,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin4FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  controller: n4,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value)  => nextField(value, pin5FocusNode),

                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin5FocusNode,
                  obscureText: true,
                  controller: n5,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value)  => nextField(value, pin6FocusNode),

                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin6FocusNode,
                  obscureText: true,
                  controller: n6,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin6FocusNode.unfocus();
                      // Then you need to check is the code is correct or not
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "استمرار",
            press: () {
           //  print(n1.text+n2.text);
              verifySmsCode(context,n1.text+n2.text+n3.text+n4.text+n5.text+n6.text);

            },
          )
        ],
      ),
    );
  }
  void verifySmsCode(BuildContext context, String code) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser previousUser = await FirebaseAuth.instance.currentUser();
    setState(() {
      isLoading = true;
    });

    //Create a PhoneCredential with the code
    AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: myVerificationId, smsCode: code);

    //Sign in the user with credential
    if (credential !=null) {
      print("gog");
    }else {
      print("bad");
    }
    await previousUser.linkWithCredential(credential).catchError((error) {
      setState(() {
        status = 'حدثت مشكلة, الرجاء اعداة المحاولة فيما بعد.';
      });
    }).then((AuthResult user) async {
      setState(() {
         status = 'تمت المصادقة بنجاح';
         writeData();
        // Navigator.pushNamed(context, HomeScreen.routeName);
         Navigator.push(context, new MaterialPageRoute(
             builder: (context) => new ProfileScreen())
         );
        // Navigator.pushNamed(context, ProfileScreen.routeName);
      });
     // onAuthenticationSuccessful();
      print(status);
    });

    setState(() {
      isLoading = false;
    });

    //print("ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
  }

  void writeData() async{
    final ref = FirebaseDatabase.instance.reference().child('Users');
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;
    ref.child(uid).update({
      'phone':'${widget.s}',

    });

  }



}
