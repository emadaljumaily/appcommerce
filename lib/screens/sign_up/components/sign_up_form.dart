
import 'dart:async';
import 'dart:convert';
import 'package:appcommerce/custom_progress_dialog.dart';
import 'package:appcommerce/errordialog.dart';
import 'package:appcommerce/localization/languages/languages.dart';
import 'package:appcommerce/screens/complete_profile/widget/country_picker.dart';
import 'package:appcommerce/screens/otp/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/components/default_button.dart';
import 'package:appcommerce/components/form_error.dart';
import 'package:appcommerce/screens/complete_profile/complete_profile_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}
class SignUpForm extends StatefulWidget {

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final _formKey = GlobalKey<FormState>();
  final emailTextEditController = new TextEditingController();
  final passwordTextEditController = new TextEditingController();
  final fnameTextEditController = new TextEditingController();
  final adresTextEditController = new TextEditingController();
  final phoneTextEditController = new TextEditingController();
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  String actualCode='';
  bool isSending = false;
  bool isLoading = false;
  String myVerificationId = "";
  Timer _codeTimer;
  String getCodeText = "Get Code";
  String errorMessage = '';
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  String email;
  String password;
  String conform_password;
  String firstName;
  String phoneNumber;
  String address;
  bool remember = false;
  var _loading=false;
  final List<String> errors = [];
  ProgressDialog _progressDialog=new ProgressDialog();
  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  String errorMsg = "";
  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
   String uid;
   String emaiil;
  var _dialCode = '';
  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }
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
  final List<Inform> todo=[];
  Future<void> clickOnLogin(BuildContext context,String a,String b, {Inform todo}) async {
    if (phoneTextEditController.text.isEmpty) {
      showErrorDialog(context, 'Contact number can\'t be empty.');
    } else {
      // String ii=a+b;
      verifyPhoneNumber(context, a+b);
      print("jhghjg :"+a+b);
      final responseMessage =
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen(a+b,todo: todo,)));
      if (responseMessage != null) {
        showErrorDialog(context, responseMessage as String);
      }
    }
  }
   @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
         buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
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
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          _loading?Center(child: CircularProgressIndicator(color: Color(0xFFFF0036),),):
          DefaultButton(
            text: Languages.of(context).createacount,
            press: () async {

           // sendData();

             // addImageToFirebase();

              //Navigator.pushNamed(context, CompleteProfileScreen.routeName);
             if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
               /* inform ff=new inform(emailTextEditController.text, fnameTextEditController.text,
                    adresTextEditController.text, phoneTextEditController.text, passwordTextEditController.text);

                todo.add(ff);*/
               // await Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen(_dialCode+phoneTextEditController.text,todo: todo[0])));
               _validateRegisterInput();
                setState(() {
                  _loading=true;
                });



              }



            },
          ),
        ],
      ),
    );
  }
  TextFormField buildAddressFormField() {
    return TextFormField(
     // textAlign: TextAlign.right,
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
        prefixIcon: Icon(
          Icons.location_on,
          color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      //textAlign: TextAlign.right,
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
     // textAlign: TextAlign.right,
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
        prefixIcon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
      ),
    );
  }
  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
       // labelText: "Confirm Password",
        hintText:Languages.of(context).repassword,

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
            color: Colors.black54,fontSize: 18, fontFamily:"beIN"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
       // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      controller: passwordTextEditController,
      decoration: InputDecoration(
       // labelText: "Password",
        hintText:Languages.of(context).password,

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
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
            color: Colors.black54,fontSize: 18, fontFamily:"beIN"),
       // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      controller: emailTextEditController,
      decoration: InputDecoration(
        //labelText: "Email",
        hintText:Languages.of(context).email,

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
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
            color: Colors.black54,fontSize: 18, fontFamily:"beIN"),
       // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
        prefixIcon: Icon(
          Icons.alternate_email,
          color: Colors.grey,
        ),
      ),
    );
  }
  /*Future<String> getUID() async {

    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;

    final pref = await SharedPreferences.getInstance();
    final key = 'uid';
    final value =uid;
    pref.setString(key, value);

    return uid;
  }*/
  void writeData() async{
    final ref = FirebaseDatabase.instance.reference().child('Users');
    final FirebaseUser user = await firebaseAuth.currentUser();
      uid = user.uid;
    ref.child(uid).set({
      'Email':user.email,
      'id':user.uid

    });
    /*Future<String> getUID() async {
      final FirebaseUser user = await firebaseAuth.currentUser();
      // uid = user.uid;
      email=user.email;
      final pref = await SharedPreferences.getInstance();
      final key = 'uid';
      final value =uid;
      pref.setString(key, value);
      // here you write the codes to input the data into firestore
      print("emaaaad     :"+emaiil);
      return uid;
    }*/
  }
  void _validateRegisterInput() async {


    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();

      try {
       // _progressDialog.showProgressDialog(context,textToBeDisplayed: 'انشاء حساب...',dismissAfter: Duration(seconds: 3));
      //  await _progressDialog.dismissProgressDialog(context);
        await firebaseAuth.createUserWithEmailAndPassword(email: emailTextEditController.text, password: passwordTextEditController.text).
        then((_) {
          firebaseAuth.signInWithEmailAndPassword(
              email: emailTextEditController.text,
              password: passwordTextEditController.text).then((user) async {
             _progressDialog.dismissProgressDialog(context);
             Inform ff=new Inform(emailTextEditController.text, fnameTextEditController.text,
                 adresTextEditController.text, phoneTextEditController.text, passwordTextEditController.text);

             todo.add(ff);
            print("kkkkk");


               //getUID();
              writeData();
             clickOnLogin(context,_dialCode,phoneTextEditController.text,todo:todo[0]);
             // sendData();
              //addImageToFirebase(file);
            /*  _sheetController.setState(() {
              _loading = false;
            });*/
            //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CompleteProfileScreen(email)));
            //_navigateToNextScreen(context);
             // Navigator.pushNamed(context, CompleteProfileScreen.routeName);

          }).catchError((onError) {


          });
        });
      }catch (signUpError) {
        setState(() {
          _loading=false;
        });

        switch (signUpError.code) {
          case "ERROR_EMAIL_ALREADY_IN_USE":
            {
              Navigator.pop(context);
             // await _progressDialog.dismissProgressDialog(context);
              errorMsg =
              "الايميل الذي ادخلته مسجل بالفعل.";


              //  _showDialog1(context,errorMsg);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text(errorMsg),
                      actions: [
                        FlatButton(
                          child: Text("حسناً"),
                          onPressed: () {

                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });


            } break;

        }




       // print(signUpError."message");




      }

    } else {
      setState(() {
        _loading=false;
      });

    }
    setState(()  {

    });
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

  Future<void> sendData() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;
    bool error, sending, success;
    String msg;
    String phpurl = "http://192.168.0.105/test/signup/signup.php";

    var res = await http.post(Uri.parse(phpurl), body: {
      "uid": uid,
      "email": emailTextEditController.text,
      "password": passwordTextEditController.text,

    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if(data["error"]){
        setState(() { //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["message"]; //error message from server
        });
      }else{

       // emailTextEditController.text = "";
       // passwordTextEditController.text = "";


        //after write success, make fields empty

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }

    }else{
      //there is error
      setState(() {
        error = true;
        msg = "Error during sendign data.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }






}
class Inform {
  final String email;
  final String name;
  final String address;
  final String phone;
  final String password;


  Inform(this.email, this.name,this.address,this.phone,this.password);
}