import 'package:flutter/material.dart';

import 'setting/body.dart';



class SetScreen extends StatelessWidget {
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
