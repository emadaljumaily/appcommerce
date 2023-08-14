import 'package:appcommerce/components/default_button.dart';
import 'package:appcommerce/localization/languages/languages.dart';
import 'package:appcommerce/localization/locale_constant.dart';
import 'package:appcommerce/models/language_data.dart';
import 'package:appcommerce/provider/categor.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/constants.dart';
import 'package:appcommerce/size_config.dart';
import 'package:provider/provider.dart';
class Body extends StatelessWidget {
  final DefaultData defaultData = DefaultData();
  LanguageData _languageData;
  void change_language(context,String dd){
    return Provider.of<Categors>(context,listen: false).changelang(dd);
  }
  String lang(context){
    return Provider.of<Categors>(context,listen: false).lang;
  }


  void select_language(context,String language){
    return Provider.of<Categors>(context,listen: false).selectlanguage(language);
  }
  String getselectlang(context){
    return Provider.of<Categors>(context,listen: false).selectlang;
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(

        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Consumer<Categors>(
                    builder: (context, cart, child) {
                      return Text(
                          "${Languages.of(context).lang} : ${Languages.of(context).langselect}",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(16),
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),

                      );
                    }),
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  //  Text('Let\'s speak '),
                    Container(
                      width: getProportionateScreenWidth(170),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Color(0x33FF0036),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:Row(children: [
                        _createLanguageDropDown(context),
                      
                      ],)
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%

                DefaultButton(
                  text: "${Languages.of(context).btnlang}   ",
                  press: () {
                    //changeLanguage(context, language.languageCode)
                    changeLanguage(context,getselectlang(context));
                    
                    print(lang(context));

                  },
                ),

              ],
            ),


      ),
    );
  }
  _createLanguageDropDown(BuildContext context) {
    return DropdownButton<LanguageData>(
      iconSize: 30,
      hint: Text(Languages.of(context).labelSelectLanguage),
      onChanged: (LanguageData language) {
        print(language.name);

        change_language(context, language.name);
        select_language(context, language.languageCode);
        print(lang(context));
      },
      items: LanguageData.languageList()
          .map<DropdownMenuItem<LanguageData>>(
            (e) =>
            DropdownMenuItem<LanguageData>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    e.flag,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(e.name)
                ],
              ),
            ),
      )
          .toList(),
    );
  }
}
class DefaultData {
  List<String> _languagesListDefault = [
    'English',
    'العربية',  ];
  get languagesListDefault => _languagesListDefault;
}