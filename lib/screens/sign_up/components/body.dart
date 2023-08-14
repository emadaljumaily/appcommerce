import 'package:appcommerce/localization/languages/languages.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/size_config.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text(Languages.of(context).createacount, style: TextStyle(fontFamily:"beIN",fontSize: 27,fontWeight: FontWeight.bold),),
                Text(
                  Languages.of(context).descriptcreateaccount,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily:"beIN"),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
             /*   Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    SocalCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),

                  ],
                ),*/
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  'من خلال الاستمرار سيتم تأكيد موافقتك \nعلى الشروط والاحكام الخاصة بنا',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
