
import 'package:appcommerce/localization/locale_constant.dart';
import 'package:appcommerce/provider/cart.dart';
import 'package:appcommerce/provider/categor.dart';
import 'package:appcommerce/provider/offer_products.dart';
import 'package:appcommerce/provider/productdetails.dart';
import 'package:appcommerce/provider/products.dart';
import 'package:appcommerce/provider/productsj.dart';
import 'package:appcommerce/screens/home/home_screen.dart';
import 'package:appcommerce/screens/sign_in/sign_in_screen.dart';
import 'package:appcommerce/screens/splash/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/routes.dart';
import 'package:appcommerce/theme.dart';
import 'package:appcommerce/screens/splash/secondpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'localization/localizations_delegate.dart';
import 'package:splashscreen/splashscreen.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();

 // await Firebase
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Services>(create: (_) => Services()),
        ChangeNotifierProvider<Servicess>(create: (_) => Servicess()),
        ChangeNotifierProvider<Provideroffer>(create: (_) => Provideroffer()),
        ChangeNotifierProvider<Categors>(create: (_) => Categors()),
        ChangeNotifierProvider<Productdetails>(create: (_) => Productdetails()),
        ChangeNotifierProvider<Carts>(create: (_) => Carts()),

        //  Provider<AnotherThing>(create: (_) => AnotherThing()),
      ],
      child:  MyApp(),
    ),
  );

  // runApp(MyApp());
}

class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
 final storage=new FlutterSecureStorage();

  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }
  Future <bool> checklogin()async{
    //await storage.write(key: 'log', value:"ok");
      bool a=false;
    String val=await storage.read(key: 'log');
    print('modeeee :$val');
    if(val == null){
     return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سندباد بغداد',
      theme: theme(),
      locale: _locale,
      home:FutureBuilder(
        future: checklogin(),
        builder: (BuildContext context,AsyncSnapshot<bool>snapshot){

          if(snapshot.data == false){

            return Firstpage();

          }if (snapshot.connectionState==ConnectionState.waiting){

            return Container(
              color: Colors.black26,
              child:Center( child:CircularProgressIndicator()),
            );
          }

         return Secondpage();
        },
      ),
      supportedLocales: [

        Locale('ar', ''),
        Locale('en', ''),

      ],
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            print("jjjjjj");
            return supportedLocale;
          }

        }
        print("jjjjjjkkkkkkkkkk");
        return supportedLocales.first;
      },
      routes: routes,
    );

  }


}
/*FutureBuilder(
        future: checklogin(),
        builder: (BuildContext context,AsyncSnapshot<bool>snapshot){

          if(snapshot.data == false){
            return SignInScreen();

          }if (snapshot.connectionState==ConnectionState.waiting){

            return Container(
              color: Colors.black26,
              child:Center( child:CircularProgressIndicator()),
            );
          }

          return HomeScreen();
        },
      ),*/
