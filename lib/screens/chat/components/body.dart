

import 'package:flutter/material.dart';
import '../../../dialog.dart';
import '../../../size_config.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Body extends StatelessWidget {
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _msgcontrol=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(
          color: Colors.red,
        )
    );
    Size size = MediaQuery.of(context).size;
    return Form(
     // padding: EdgeInsets.symmetric(vertical: 20),
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.09),
          Text('ارسال رسالة الى الدعم الفني',
            style: TextStyle( fontSize: getProportionateScreenWidth(18),
                fontFamily:"beIN",
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          SizedBox(height: size.height * 0.09),
          Container(
            padding:  new EdgeInsets.only(left: 12),
            width: 400,
             child: TextFormField(
               controller: _msgcontrol,
                minLines: 6, // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                maxLines: null,

               decoration: InputDecoration(
                   //focusedBorder: null,
                   border: border,
                 fillColor: Colors.white,

                      filled: true,
                 focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(25.0),
                   borderSide: BorderSide(
                     color: Colors.black12,
                   ),
                 ),
                 enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(25.0),
                   borderSide: BorderSide(
                     color: Colors.black12,
                     width: 2.0,
                   ),
                 ),
                  // fillColor: kPrimaryLightColor,
                  ),
              )
          ),
          SizedBox(height: size.height * 0.09),
          new Container(
           // width: double.infinity,
            width: 250,
            child:ClipRRect(

              borderRadius: BorderRadius.circular(20),
              // ignore: deprecated_member_use
              child: FlatButton(

                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),

                color: Color(0xFFFF0036),
                onPressed: () async{

                  sendmsg();
                  showDialog(context: context,
                      builder: (BuildContext context){
                        return CustomDialogBox(
                          title: "",
                          descriptions: "تم الارسال",
                          text: "حسناً",
                        );
                      }
                  );

                },
                child: Text(
                  'أرسـال',
                  style: TextStyle(
                    fontSize: 19,
                      fontWeight: FontWeight.bold,
                      fontFamily:"beIN",
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void sendmsg()async{
    final ref = await FirebaseDatabase.instance.reference().child('Msg');
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;

    ref.child(uid).set({
      'id':uid,
      'msg':_msgcontrol.text

    });
  }
}
