import 'package:appcommerce/localization/languages/languages.dart';
import 'package:appcommerce/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';


import '../constants.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [


        Text(
          "${Languages.of(context).nohaveacount
    }؟ ",
          style: TextStyle(fontSize: getProportionateScreenWidth(18),fontFamily:"beIN"),
        ),
        new Padding(padding: new EdgeInsets.only(right:10)),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            Languages.of(context).create,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                fontWeight: FontWeight.bold,
                fontFamily:"beIN",
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
