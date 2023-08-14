
import 'package:flutter/material.dart';
import 'package:appcommerce/screens/splash/components/body.dart';

import '../../size_config.dart';
class SplashScreen extends StatefulWidget{

  static String routeName = "/splashscreen";
  const SplashScreen({Key key}) : super(key: key);
  @override
  Cc createState() => Cc();


}

class Cc extends State<SplashScreen>{


  @override
  void initState() {

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }


}


