import 'dart:async';
import 'dart:collection';
import 'package:appcommerce/custom_progress_dialog.dart';
import 'package:appcommerce/localization/languages/languages.dart';
import 'package:appcommerce/screens/complete_profile/widget/country_picker.dart';
import 'package:appcommerce/screens/profile/otpedit/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/components/default_button.dart';
import 'package:appcommerce/components/form_error.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../constants.dart';
import '../../../dialog.dart';
import '../../../size_config.dart';

class DetForm extends StatefulWidget {

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<DetForm> {

  final _formKey = GlobalKey<FormState>();
  final nameTextEditController = new TextEditingController();
  final adresTextEditController = new TextEditingController();
  final phoneTextEditController = new TextEditingController();
  final ppTextEditController = new TextEditingController();
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  String email;
  String password;
  String conform_password;
  bool remember = false;
  final List<String> errors = [];
  ProgressDialog _progressDialog=new ProgressDialog();
  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }
  bool _loading = false;
  String errorMsg = "";
  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  String actualCode='';
  bool isSending = false;
  bool isLoading = false;
  String myVerificationId = "";
  Timer _codeTimer;
  String getCodeText = "Get Code";
  String errorMessage = '';
  String name;
  String pnn;
  String adres;
  String phoneNumber;
   String uiid;
   String emaiil;
  Future<String> getdata() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;

    final db =await FirebaseDatabase.instance.reference().child("Users/${uid}/");

    db.once().then((DataSnapshot snapshot) {
      //print('Data : ${snapshot.value}');
      print('uuuuu : ${snapshot.value['id']}');
      name=snapshot.value['Name'];
      adres=snapshot.value['Address'];
      pnn=snapshot.value['phone'];
      print('phoneee ${pnn}');
      nameTextEditController.text=name;
      adresTextEditController.text=adres;
      ppTextEditController.text=pnn;

    });
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
  Future<void> clickOnLogin(BuildContext context,String a,String b) async {
    if (phoneTextEditController.text.isEmpty) {
      showErrorDialog(context, 'Contact number can\'t be empty.');
    } else {
      // String ii=a+b;
      verifyPhoneNumber(context, a+b);
      // print("jhghjg :"+a+b);
      final responseMessage =
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpeScreen(a+b)));
      if (responseMessage != null) {
        showErrorDialog(context, responseMessage as String);
      }
    }
  }
  var _dialCode = '';
  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }
  @override
  void initState() {
    super.initState();
    print('mmmmmmmmmmmmmmmm');
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNamejFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildadresFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildphoneFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            // ignore: prefer_const_literals_to_create_immutables
              children: [
                CountryPicker(
                  callBackFunction: _callBackFunction,
                  headerText: 'اختر الدولة',
                  headerBackgroundColor: Theme.of(context).primaryColor,
                  headerTextColor: Colors.white,

                ),
                SizedBox(
                  width: screenWidth * 0.02,
                ),
                Expanded(
                  child:buildPhoneNumberFormField(),)]),

              Padding(
                //left: 10,
                  padding:
                  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                child: TextButton(
                    onPressed:(){
                      clickOnLogin(context,_dialCode,phoneTextEditController.text );
                    },
                    child: Text('${Languages.of(context).btnphonechange}',
                      style: TextStyle(color: Color(0xFFFF0036),fontFamily: 'beIN',fontSize: 15,fontWeight: FontWeight.bold),


                    )
                )
            ),


          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "${Languages.of(context).btnlang}   ",
            press: () {

             writeData();
             showDialog(context: context,
                 builder: (BuildContext context){
                   return CustomDialogBox(
                     title: "",
                     descriptions: "تم تحديث البيانات",
                     text: "حسناً",
                   );
                 }
             );
            },
          ),
        ],
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
        hintText: "${Languages.of(context).newnumber}",
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

  Directionality buildNamejFormField(){

    return Directionality(
        textDirection: TextDirection.rtl,

        child: TextFormField(

          textAlign: TextAlign.right,
          autofocus: true,
          controller: nameTextEditController,
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
            labelText: "${Languages.of(context).fullname} ",
           // hintText: 'الاسم الاول',
          ),
        )
    );
  }
  Directionality buildphoneFormField(){

    return Directionality(
        textDirection: TextDirection.rtl,

        child: TextFormField(
          readOnly: true,
          textAlign: TextAlign.right,
          autofocus: true,
          controller: ppTextEditController,
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
            labelText: "${Languages.of(context).phone}",
            // hintText: 'الاسم الاول',
          ),
        )
    );
  }

  Directionality buildadresFormField(){

    return Directionality(
        textDirection: TextDirection.rtl,

        child: TextFormField(

          textAlign: TextAlign.right,
          autofocus: true,
          controller: adresTextEditController,
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
            labelText: "${Languages.of(context).addresstitle}",
           // hintText: 'الاسم الاول',
          ),
        )
    );
  }



  void writeData() async{
    //await _progressDialog.showProgressDialog(context,textToBeDisplayed: 'تحديث المعلومات',dismissAfter: Duration(seconds: 3));
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;

   // final db =await FirebaseDatabase.instance.reference().child("Users/${uid}/");
    final ref = FirebaseDatabase.instance.reference().child("Users/");
    Map<String, Object> createDoc = new HashMap();
    createDoc['Name'] = nameTextEditController.text;
    createDoc['Address'] = adresTextEditController.text;
    ref.child('${uid}/').update(createDoc);

   // _progressDialog.dismissProgressDialog(context);


  }
  void verifyPhoneNumber(BuildContext context, String phone) async {

    int duration = 60;
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.actualCode = verificationId;
      setState(() {
        print('Code sent to $phone');
        String status = "\nEnter the code sent to " + phone;
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
    FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser previousUser = await FirebaseAuth.instance.currentUser();
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (AuthCredential credential) async {
        await previousUser.updatePhoneNumberCredential(credential);

        print("goooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooodddddd");
      },
      timeout: const Duration(seconds: 60),
      verificationFailed: (Exception error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('error.code')));
      },
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) => null,
    );
  }



}
