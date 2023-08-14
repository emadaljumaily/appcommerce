
import 'package:appcommerce/localization/languages/languages.dart';
import 'package:appcommerce/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/components/form_error.dart';
import 'package:appcommerce/helper/keyboard.dart';
import 'package:appcommerce/screens/forgot_password/forgot_password_screen.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../custom_progress_dialog.dart';
import '../../../size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:translator/translator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
final storage=new FlutterSecureStorage();
  final _contactEditingController=new TextEditingController();
  final _passEditingController=new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ProgressDialog _progressDialog=new ProgressDialog();

  String errorMsg = "";
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  bool _loading = false;
  bool _autoValidate = false;
  String email;
  String password;
  bool remember = false;
  String emaiil="";
  String emaill="";
  String uid;
  final List<String> errors = [];

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
  bool hidtext = true;
  void _toggle(){
    setState(() {
      hidtext=!hidtext;
    });

  }



//GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
Future translation()async{
  final translator = GoogleTranslator();
  final input = "Здравствуйте. Ты в порядке?";
  translator
      .translate(input, to: 'ar')
      .then((result) => print("Source: $input\nTranslated: $result"));

}


  @override
  void initState() {
    //checkVersion();
//translation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text(Languages.of(context).remember,

                style: TextStyle(
                  fontSize:16,

                  fontWeight: FontWeight.bold,
                    fontFamily:"beIN"
                ),

              ),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                    Languages.of(context).forget,
                  style: TextStyle(decoration: TextDecoration.underline,fontSize:16,fontWeight: FontWeight.bold,fontFamily:"beIN"),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          _loading?Center(child: CircularProgressIndicator(color: Color(0xFFFF0036),),):
          DefaultButton(
            text:Languages.of(context).signin,

            press: () async {
              //SharedPreferences _prefs = await SharedPreferences.getInstance();
              // await storage.write(key:prefSelectedLanguageCode, value:languageCode);
              //await _prefs.setString('named', 'emad');
              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetScreen()));
             if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                 KeyboardUtil.hideKeyboard(context);
                 _validateLoginInput();
               setState(() {
                 _loading=true;
               });

                  //Navigator.pushNamed(context, LoginSuccessScreen.routeName);

              }
            },
          ),


        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    SizeConfig().init(context);
    return TextFormField(
      obscureText: hidtext,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
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
      style: TextStyle(fontSize: 18),
      controller: _passEditingController,
      decoration: InputDecoration(
        //labelText: "Password",
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
        hintStyle: TextStyle(
            color: Colors.black54,fontSize: 18, fontFamily:"beIN"),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.grey,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          onTap: _toggle,
          child: hidtext

              ? Icon(Icons.visibility,color:Colors.grey,)
              : Icon(Icons.visibility_off,color:Color(0xFFFF0036),),

          /* onTap: _toggle(),
                Icons.visibility,
                color: Colors.pink.shade900,
*/
        ), //CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }


  TextFormField buildEmailFormField() {
    SizeConfig().init(context);
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
      controller: _contactEditingController,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
       // labelText: "Email",
    fillColor: Colors.white,
    /*
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(
    color: Colors.blue,
    ),),*/
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

        hintStyle: TextStyle(
            color: Colors.black54,fontSize: 18, fontFamily:"beIN"),
        hoverColor: Colors.pink,
        hintText:Languages.of(context).email,

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
      ),
    );
  }

  void _validateLoginInput() async {

    emaill=_contactEditingController.text;

    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();



      try {


       final uu= await firebaseAuth.signInWithEmailAndPassword(email: _contactEditingController.text, password: _passEditingController.text);

        if (await FirebaseAuth.instance.currentUser() != null) {
          if(remember){
            await storage.write(key: 'uid', value: uu.user.uid);
          }else{

          }


          setState(() {
            getUID();
            Navigator.pushNamed(context, HomeScreen.routeName);
          });

          //_navigateToNextScreen(context);
        } else {

        }


      } catch (error) {
        setState(() {
          _loading=false;
        });
        switch (error.code) {
          case "ERROR_USER_NOT_FOUND":
            {
             // await _progressDialog.dismissProgressDialog(context);
              errorMsg =
              "لايوجد ايميل يتطابق مع الايميل الذي ادخلته. الرجاء اعداة المحاولة";

              _loading = false;

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
            }
            break;
          case "ERROR_WRONG_PASSWORD":
            {
              await _progressDialog.dismissProgressDialog(context);
              errorMsg = "كلمة المرور غير صحيحة";
              _loading = false;

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
            }
            break;
          default:
            {
              _loading=false;
             // await _progressDialog.dismissProgressDialog(context);
              errorMsg = "";

            }
        }
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
  Future<String> getUID() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;
    emaiil=user.email;

    // here you write the codes to input the data into firestore
    //  print("emaaaad     :"+email);
    return uid;
  }
 // String imgprofile='';
  //String hh='https://firebasestorage.googleapis.com/v0/b/store-8de56.appspot.com/o/Profile%2FBhZQ1ie4CrdOehoy7qPNvAN2z0S2.png?alt=media&token=b490b0a3-689e-4c9f-92b7-79c455a42eb5';


}
