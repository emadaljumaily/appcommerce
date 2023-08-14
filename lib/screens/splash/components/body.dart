import 'package:appcommerce/localization/languages/languages.dart';
import 'package:appcommerce/localization/locale_constant.dart';
import 'package:appcommerce/models/language_data.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/constants.dart';
import 'package:appcommerce/screens/sign_in/sign_in_screen.dart';
import 'package:appcommerce/size_config.dart';
// This is the best practice
import '../components/splash_content.dart';
import '../../../components/default_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final storage=new FlutterSecureStorage();
  int currentPage = 0;


@override
  void initState() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
   // _showDecline();
    openAlertBox();
  });

  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Map<String, String>> splashData = [
      {
        "text":Languages.of(context).text1,
        "image": "assets/images/sp1.png"
      },
      {
        "text":Languages.of(context).text2,
        "image": "assets/images/sp2.png"
      },
      {
        "text": Languages.of(context).text3,
        "image": "assets/images/splash_3.png"
      },
    ];
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: Languages.of(context).button_complete,
                      press: () async{
                        await storage.write(key: 'log', value: 'ok');
                        setState(() {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        });

                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    SizeConfig().init(context);
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 7),
      height: 6,
      width: currentPage == index ? 15 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: getProportionateScreenWidth(300),
              child: Column(

                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(

                    child:Text(
                        "Language - اللغة",
                        style: TextStyle(fontSize: 24.0),
                      ),

                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                   Text("select language - اختر اللغة"),
                  SizedBox(
                    height: 5.0,
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: new DropdownButton<LanguageData>(
                        iconSize: 30,
                        hint: Text(Languages.of(context).labelSelectLanguage),
                        onChanged: (LanguageData language) {
                          print(language.languageCode);
                          changeLanguage(context, language.languageCode);
                          // Navigator.of(context).pop();



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
                                      //'e.flag',
                                      '',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    Text(e.name)
                                  ],
                                ),
                              ),
                        )
                            .toList(),
                      )
                  ),
                 /* Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Add Review",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),*/
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Container(
                      width: getProportionateScreenWidth(300),
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF0036),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        Languages.of(context).close,
                        style: TextStyle(color: Colors.white,
                            fontSize: 16,
                            fontFamily:"beIN",
                          fontWeight: FontWeight.bold



                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap:(){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }


}
