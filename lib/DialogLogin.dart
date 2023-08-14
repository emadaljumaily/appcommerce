import 'dart:async';
import 'package:appcommerce/models/Catgory.dart';
import 'package:appcommerce/models/Data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  final String title;
  final FirebaseAuth auth;

  const CustomAlertDialog({Key key, this.title, this.auth})
      : super(key: key);

  @override
  CustomAlertDialogState createState() {
    return new CustomAlertDialogState();
  }
}

class CustomAlertDialogState extends State<CustomAlertDialog> {

  final _resetKey = GlobalKey<FormState>();
  final _LoginController = TextEditingController();
  //String _resetEmail;
  bool _resetValidate = false;
  String valpass='';
  StreamController<bool> rebuild = StreamController<bool>();

  bool _checklogin() {
    //_resetEmail = _LoginController.text;

    if (_resetKey.currentState.validate()) {
      _resetKey.currentState.save();

      try {
        // You could consider using async/await here
        rootFirebaseIsExists(_LoginController.text);
        return true;
      } catch (exception) {
        print(exception);
      }
    } else {
      setState(() {
        _resetValidate = true;
      });
     /// return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: AlertDialog(
        title: new Text(widget.title),
        content: new SingleChildScrollView(
          child: Form(
            key: _resetKey,
           // autovalidate: _resetValidate,

            child: ListBody(
              children: <Widget>[
                new Text(
                  '',
                  style: TextStyle(fontSize: 14.0),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Row(
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.lock,
                        size: 20.0,
                        color: Colors.grey,
                      ),
                    ),
                    new Expanded(
                      child: TextFormField(
                        validator: validateEmail,

                        controller: _LoginController,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: true,
                        decoration: new InputDecoration(
                          // border: InputBorder.none,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            hintText: 'كلمة المرور',
                            contentPadding:
                            EdgeInsets.only(left: 70.0, top: 15.0),
                            hintStyle:
                            TextStyle(color: Colors.black38, fontSize: 20.0)


                        ),
                        style: TextStyle(color: Colors.black),

                      ),
                    )
                  ],
                ),
                new Column(children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: new BorderSide(
                                width: 0.5, color: Colors.black12))),
                  )
                ]),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text(
              'CANCEL',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop("");
            },
          ),
          new FlatButton(
            child: new Text(
              'LOGIN',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              //rootFirebaseIsExists();
              if(_checklogin() ==true){

              }else{

              }


            },
          ),
        ],
      ),
    );
  }

  void rootFirebaseIsExists(String pass) async {
    List<Category> datalist = [];
    List<Dataa> datalista = [];
    DatabaseReference ref = FirebaseDatabase.instance.reference().child("ctegory/");

    ref.once().then((DataSnapshot datasnapshot) {
      datalist.clear();
      var keys = datasnapshot.value.keys;
      var values = datasnapshot.value;
      for (var key in keys) {
        Category data = new Category(
          values[key]['pass'],

        );
        datalist.add(data);



        if (data.pass.contains(pass)) {
          String ps;
          DatabaseReference keyRef = FirebaseDatabase.instance.reference();
           keyRef.child('ctegory')
              .orderByChild('pass')
              .equalTo(pass)
              .onChildAdded.listen((Event event) {
                ps=event.snapshot.key;
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JomlaScreen()),
                );*/
                 print(ps);


          }, onError: (Object o) {
            final DatabaseError error = o;
            print('Error: ${error.code} ${error.message}');
          });


          print("login");
          setState(() {

          });

        } else {

          final snackBar = SnackBar(content: Text('Wrong Password......!!',style: TextStyle(fontSize: 18.0),));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
         // print("fff");
        }
      }
    });

  }
  String validateEmail(String value) {
value=_LoginController.text;
    if (value.length == 0) {
      return "password is required";
    }  else {
      return null;
    }
  }
}




