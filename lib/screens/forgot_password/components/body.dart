import 'package:appcommerce/custom_progress_dialog.dart';
import 'package:appcommerce/localization/languages/languages.dart';
import 'package:appcommerce/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/components/custom_surfix_icon.dart';
import 'package:appcommerce/components/default_button.dart';
import 'package:appcommerce/components/form_error.dart';
import 'package:appcommerce/components/no_account_text.dart';
import 'package:appcommerce/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../constants.dart';

class Body extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                Languages.of(context).welcomeforget,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                Languages.of(context).descriptforget,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  ProgressDialog _progressDialog=new ProgressDialog();
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailController=new TextEditingController();
  List<String> errors = [];
  String email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
             // labelText: "Email",
              hintText: Languages.of(context).emailforget,
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
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
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: Languages.of(context).send,
            press: () {
              if (_formKey.currentState.validate()) {

               _passwordReset(_emailController.text);

              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
  Future _passwordReset(String email) async {

    try {
      _progressDialog.showProgressDialog(context,textToBeDisplayed: 'ارسال الايميل',dismissAfter: Duration(seconds: 1));
      await firebaseAuth.sendPasswordResetEmail(email: email);
      _progressDialog.dismissProgressDialog(context);
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('ارسلنا رابط استعداة كلمة السر الى  \n ${_emailController.text}'),
              actions: [

                FlatButton(
                  onPressed: (){

                    Navigator.pop(context, true);
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) => new SignInScreen())
                    );
                  }, // passing true
                  child: Text('حسناً',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),

                ),
              ],
            );
          });
    }catch(Exception){
        print(Exception);
    }
  }
}
