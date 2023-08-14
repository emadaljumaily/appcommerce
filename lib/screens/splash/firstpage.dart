import 'package:appcommerce/screens/home/home_screen.dart';
import 'package:appcommerce/screens/sign_in/sign_in_screen.dart';
import 'package:appcommerce/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../size_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Firstpage extends StatefulWidget {
  static String routeName = "/Firstpage";

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Firstpage> {
  final storage=new FlutterSecureStorage();
String vall='';


  Future<bool> checklog()async{
    Future.delayed(Duration(seconds:2 ), ()async{
      String val = await storage.read(key: 'log');
      if(val == null){
        vall=val;

        return false;
      }
      vall="ok";
      return true;

    });


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
     return new Scaffold(
       body:FutureBuilder(
         future: _calculation,
         builder: (BuildContext context,snapshot){
           if (snapshot.connectionState==ConnectionState.waiting){
             return Container(
               width: 400,
               height: 700,
               padding:EdgeInsets.only(left: 10),

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

             );

           }if(vall == null){
             return SplashScreen();
           }
           return SignInScreen();

         },
       ),

        /*body: new Container(
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

          /*child:  Image.asset(
            'assets/images/Splas.png',
            height: getProportionateScreenHeight(265),
            width: getProportionateScreenWidth(235),
          ),*/
    )*/
    );
   /* return new Scaffold(

      body: new Container(
        width: 400,
          height: 700,
          padding:
          EdgeInsets.only(left: 10),

    child:FutureBuilder(
        future: checklog(),
        builder: (BuildContext context,AsyncSnapshot<bool>snapshot){
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
              /*  return Center(

                child: new Text(
                    "!...مرحبـاً من جديد",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),



                );*/

            }else{

                return HomeScreen();





            }



          }




      ),
      ),



    );*/
  }
}
