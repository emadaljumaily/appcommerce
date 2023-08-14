import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),

      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: kPrimaryColor,
            alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 0),
        ),
        onPressed: press as void Function(),



         child: Text(
          text,


          style: TextStyle(
            fontSize: 22,
           // fontWeight: FontWeight.bold,
            color: Colors.white,
              fontFamily:"beIN"
          ),
        ),
      ),
    );
  }
}
