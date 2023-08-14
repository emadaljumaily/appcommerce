import 'package:flutter/material.dart';

import 'languages//body.dart';



class LangScreen extends StatelessWidget {
  static String routeName = "/language";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" "),
      ),
      body: Body(),
    );
  }
}
