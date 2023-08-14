import 'dart:async';
import 'dart:convert';
import 'package:appcommerce/localization/languages/languages.dart';
import 'package:appcommerce/screens/complete_profile/widget/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/components/default_button.dart';
import 'package:appcommerce/components/form_error.dart';
import 'package:appcommerce/screens/otp/otp_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../../constants.dart';
import '../../../errordialog.dart';
import '../../../size_config.dart';


enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class CompleteProfileForm extends StatefulWidget {
  String a='ggggggggg';
 String b='';

    CompleteProfileForm({this.a});
 //CompleteProfileForm(this.cp,this.pp);
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  //String ph=this.;
  String actualCode='';
  bool isSending = false;
  bool isLoading = false;
  String myVerificationId = "";
   Timer _codeTimer;
  String getCodeText = "Get Code";
  String errorMessage = '';
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final fnameTextEditController = new TextEditingController();
  final adresTextEditController = new TextEditingController();
  final phoneTextEditController = new TextEditingController();
  final List<String> errors = [];
  String firstName;

  String phoneNumber;
  String address;
    String email;
   String uid;
  bool showLoading = false;
  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  String smsOTP;
String aa='';
  var _dialCode = '';
  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }
//Alert dialogue to show error and response
void showErrorDialog(BuildContext context, String message) {
  // set up the AlertDialog
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: const Text('Error'),
    content: Text('\n$message'),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: true,
        child: const Text('حسناً'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
Future<void> clickOnLogin(BuildContext context,String a,String b) async {
  if (phoneTextEditController.text.isEmpty) {
    showErrorDialog(context, 'Contact number can\'t be empty.');
  } else {
   // String ii=a+b;
verifyPhoneNumber(context, a+b);
   // print("jhghjg :"+a+b);
    final responseMessage =
     await Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen(a+b)));
    if (responseMessage != null) {
      showErrorDialog(context, responseMessage as String);
    }
  }
}

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widget.a;
    final screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          SizedBox(height: getProportionateScreenHeight(30)),
       Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          CountryPicker(
            callBackFunction: _callBackFunction,
            headerText: Languages.of(context).contry,
            headerBackgroundColor: Theme.of(context).primaryColor,
            headerTextColor: Colors.white,

          ),
          SizedBox(
            width: screenWidth * 0.01,
          ),
         Expanded(child:buildPhoneNumberFormField(),)]),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: Languages.of(context).button_complete,
            press: () {

            //clickOnLogin(context,_dialCode,phoneTextEditController.text);

             if (_formKey.currentState.validate()) {
                getUID();
                writeData();
               // sendData();
                //verifyPhoneNumber(context,_dialCode+phoneTextEditController.text);


                clickOnLogin(context,_dialCode,phoneTextEditController.text );
               // Navigator.pushNamed(context, OtpScreen.routeName,arguments: ph);

                // aa=phoneTextEditController.text;
               // Navigator.pushNamed(context, LoginSuccessScreen.routeName);

              }


            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
        textAlign: TextAlign.right,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      controller: adresTextEditController,
      decoration: InputDecoration(
        //labelText: "Address",
        hintText:Languages.of(context).address,
        border:  UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        enabledBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        errorBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        disabledBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        hintStyle: TextStyle(
            color: Colors.black54,fontSize: 18, fontFamily: "WorkSansLight"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
       // suffixIcon:CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      textAlign: TextAlign.right,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      controller: phoneTextEditController,
      decoration: InputDecoration(
       // labelText: "Phone Number",
        hintText:Languages.of(context).phone,
        border:  UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        enabledBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        errorBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        disabledBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        hintStyle: TextStyle(
            color: Colors.black54,fontSize: 18, fontFamily: "WorkSansLight"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
       // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }



  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      textAlign: TextAlign.right,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      controller: fnameTextEditController,
      decoration: InputDecoration(
       // labelText: "First Name",
        hintText: Languages.of(context).fullname,
        border:  UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        enabledBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        errorBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        disabledBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        hintStyle: TextStyle(
            color: Colors.black54,fontSize: 18, fontFamily: "WorkSansLight"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      //  suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
  Future<String> getUID() async {

    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;

    final pref = await SharedPreferences.getInstance();
    final key = 'uid';
    final value =uid;
    pref.setString(key, value);

    return uid;
  }

  void writeData() async{
    final ref = FirebaseDatabase.instance.reference().child('Users');
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;

    ref.child(uid).set({
      'Email':user.email,
      'id':user.uid,
      'Name':fnameTextEditController.text,

      'Address':adresTextEditController.text


    });
    Future<String> getUID() async {
      final FirebaseUser user = await firebaseAuth.currentUser();
      // uid = user.uid;
      email=user.email;
      final pref = await SharedPreferences.getInstance();
      final key = 'uid';
      final value =uid;
      pref.setString(key, value);
      // here you write the codes to input the data into firestore
     // print("emaaaad     :"+emaiil);
      return uid;
    }
  }
  void verifyPhoneNumber(BuildContext context, String phone) async {

    int duration = 60;
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.actualCode = verificationId;
      setState(() {
        print('Code sent to $phone');
        //String status = "\nEnter the code sent to " + phone;
      });
    };
    _codeTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {

        isSending = true;

        if (duration < 1) {
          _codeTimer.cancel();
          isSending = false;
          getCodeText = "Get Code";
        } else {
          duration--;
          getCodeText = "$duration s";
        }
        setState(() {
      });
    });

    //Phone Auth
    final FirebaseUser previousUser = await FirebaseAuth.instance.currentUser();
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (AuthCredential credential) async {
        await previousUser.updatePhoneNumberCredential(credential).then((value){}).catchError((e){
          showDialog(context: context,
              builder: (BuildContext context){
                return ErrorDialogBox(
                  title: "خطأ",
                  descriptions: "$e",
                  text: "حسنا",
                );
              }
          );
        });

        print("goooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooodddddd");
      },
      timeout:  Duration(seconds: 60),
      verificationFailed: (AuthException error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message)));
      },
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) => null,
    );
  }





}
