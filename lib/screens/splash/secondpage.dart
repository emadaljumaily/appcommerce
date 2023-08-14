
import 'package:appcommerce/errordialog.dart';
import 'package:appcommerce/screens/home/home_screen.dart';
import 'package:appcommerce/screens/sign_in/sign_in_screen.dart';
import 'package:appcommerce/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../size_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Secondpage extends StatefulWidget {
  static String routeName = "/Secondpage";

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Secondpage> {
  final storage=new FlutterSecureStorage();
String vall='';
  Future<bool> checklog()async{

      String val = await storage.read(key: 'uid');
      if (val == null) {
        vall=val;
        return false;
      }
  vall="ok";
      return true;

  }
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
        ()=>'h',
  );
  @override
  void initState() {

    super.initState();
    checklog();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
     /*return new Scaffold(

        body: new Container(
        width: 400,
        height: 700,
          padding:
          EdgeInsets.only(left: 10),

           child: CircleAvatar(
             // backgroundImage: AssetImage("assets/images/Profile Image.png"),
             backgroundColor: Colors.white,

             child: ClipOval(
               child: new SizedBox(
                 width: 350.0,
                 // height: 180.0,
                 child:Image.asset('assets/images/Splas.png'),

               ),
             ),
           ),

    ),
    );*/
   return new Scaffold(

      body: new Container(
        width: 400,
          height: 700,
          padding:
          EdgeInsets.only(left: 10),

    child:FutureBuilder(
        future:_calculation,
        builder: (BuildContext context,snapshot){
            if (snapshot.connectionState==ConnectionState.waiting){

              return CircleAvatar(
                // backgroundImage: AssetImage("assets/images/Profile Image.png"),
                backgroundColor: Colors.white,

                child: ClipOval(
                  child: new SizedBox(
                    width: 350.0,
                    // height: 180.0,
                    child:Image.asset('assets/images/Splas.png'),

                  ),
                ),
              );

            }if(vall == null){

              return SignInScreen();

            }
            return HomeScreen();

          }


      ),
      ),

    );
  }
}
