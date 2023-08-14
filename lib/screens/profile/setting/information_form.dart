import 'dart:async';
import 'package:appcommerce/custom_progress_dialog.dart';
import 'package:appcommerce/localization/languages/languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/components/default_button.dart';
import 'package:appcommerce/components/form_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../dialog.dart';
import '../../../errordialog.dart';
import '../../../size_config.dart';

class SettForm extends StatefulWidget {

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SettForm> {

  final _formKey = GlobalKey<FormState>();

  final passTextEditController = new TextEditingController();

  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;

  final List<String> errors = [];
  ProgressDialog _progressDialog=new ProgressDialog();

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
  bool hidtext = true;
  void _toggle(){
    setState(() {
      hidtext=!hidtext;
    });

  }
  @override
  void initState() {
    super.initState();
    print('mmmmmmmmmmmmmmmm');

  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Column(
        children: [

          SizedBox(height: getProportionateScreenHeight(20)),
          buildpassFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),

          SizedBox(height: getProportionateScreenHeight(20)),




          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "${Languages.of(context).btnlang}   ",
            press: () {

             writeData();

            },
          ),
        ],
      ),
    );
  }





  Directionality buildpassFormField(){

    return Directionality(
        textDirection: TextDirection.rtl,

        child: TextFormField(
          obscureText: hidtext,
          textAlign: TextAlign.right,
          autofocus: true,
          controller: passTextEditController,
          decoration: new InputDecoration(
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
            //border: OutlineInputBorder(),
            labelText: "${Languages.of(context).newpass} ",
           // hintText: 'الاسم الاول',
            suffixIcon: GestureDetector(
              onTap: _toggle,
              child: hidtext

                  ? Icon(Icons.visibility,color:Colors.grey,)
                  : Icon(Icons.visibility_off,color:Color(0xFFFF0036),),

              /* onTap: _toggle(),
                Icons.visibility,
                color: Colors.pink.shade900,
*/
            ),
          ),
        )
    );
  }



  void writeData() async{
    await _progressDialog.showProgressDialog(context,textToBeDisplayed: 'تحديث المعلومات',dismissAfter: Duration(seconds: 3));
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;

    user.updatePassword(passTextEditController.text).then((value){
      _progressDialog.dismissProgressDialog(context);
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialogBox(
              title: "",
              descriptions: "تم تغيير كلمة المرور",
              text: "حسنا",
            );
          }
      );
    }).onError((error, stackTrace){

      _progressDialog.dismissProgressDialog(context);
      showDialog(context: context,
          builder: (BuildContext context){
            return ErrorDialogBox(
              title: "",
              descriptions: error.toString(),
              text: "حسنا",
            );
          }
      );
    });




  }




}
