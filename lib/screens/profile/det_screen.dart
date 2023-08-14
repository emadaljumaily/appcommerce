import 'package:flutter/material.dart';

import 'information/body.dart';



class DetScreen extends StatelessWidget {
  //static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" معلومات الحساب"),
      ),
      body: Body(),
    );
  }
}
