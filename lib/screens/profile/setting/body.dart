import 'package:appcommerce/localization/languages/languages.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/constants.dart';
import 'package:appcommerce/size_config.dart';

import 'information_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(

        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("${Languages.of(context).btnchangepass}", style: headingStyle),

                //SizedBox(height: SizeConfig.screenHeight * 0.08),
                SettForm(),
               // SizedBox(height: SizeConfig.screenHeight * 0.08),
               // SizedBox(height: getProportionateScreenHeight(20)),

              ],
            ),
          ),

      ),
    );
  }
}
