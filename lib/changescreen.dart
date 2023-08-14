import 'package:appcommerce/custom_progress_dialog.dart';
import 'package:appcommerce/models/Catgory.dart';
import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/provider/categor.dart';
import 'package:appcommerce/screens/jomla/jomla_screen.dart';
import 'package:appcommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'components/default_button.dart';
class ChangeScreen extends StatefulWidget {
  static String routeName = "/ghg";
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<ChangeScreen> {
  ProgressDialog _progressDialog=new ProgressDialog();
  final _resetKey = GlobalKey<FormState>();
  final _LoginController = TextEditingController();
  bool _resetValidate = false;
  String vb=' ';
  bool _loading=false;
  bool res=false;
  bool _checklogin() {

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
  bool hidtext = true;
  void _toggle() {
    setState(() {
      hidtext = !hidtext;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/secure.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),

            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                onChanged:(text){
                  setState(() {
                    res=false;
                  });
                },
                controller: _LoginController,
                obscureText: hidtext,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter  password',
                suffixIcon: GestureDetector(
                  onTap: _toggle,
                  child: hidtext

                      ? Icon(Icons.visibility,color:Colors.grey,)
                      : Icon(Icons.visibility_off,color:Color(0xFFFF0036),),
                ),
                ),
              ),
            ),
           SizedBox(height: 15.0,),
            Text(
                '',//${vb}
              style: TextStyle(fontSize: 20),

            ),
            SizedBox(height: 30.0,),
            _loading?Center(child: CircularProgressIndicator(color: Color(0xFFFF0036),),):
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: DefaultButton(
                text: "LOGIN",
                press: () {
                  setState(() {
                    _loading=true;
                    res=false;
                   rootFirebaseIsExists(_LoginController.text);
                    //setValue();
                  });

                },

              ),
            ),
            SizedBox(
              height: 20,
            ),
            res?
            Text('كلمة المرور غير صحيحة',
                style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(16),
                fontWeight: FontWeight.bold,
                fontFamily: "beIN"
            ),
            ):
            Text(""),
          ],
        ),
      ),
    );
  }
  void rootFirebaseIsExists(String pass) async {
  //  _progressDialog.showProgressDialog(context,textToBeDisplayed: 'Login...',dismissAfter: Duration(seconds: 10));
    List<Category> datalist = [];
    List<Dataa> datalista = [];
    DatabaseReference ref = FirebaseDatabase.instance.reference().child("Categorpart/");

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
          keyRef.child('Categorpart')
              .orderByChild('pass')
              .equalTo(pass)
              .onChildAdded.listen((Event event) {
            ps=event.snapshot.key;
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JomlaScreen(ps)),
                );
            print(ps);


          }, onError: (Object o) {

            final DatabaseError error = o;
            print('Error: ${error.code} ${error.message}');
          });


          print("login");
          setState(() {
          vb='Success';
          });
        //_progressDialog.dismissProgressDialog(context);
        } else {

          //_progressDialog.dismissProgressDialog(context);
         setState(() {
           res=true;
           _loading=false;
          vb='Error';
         });


        }
      }
    });

  }
}