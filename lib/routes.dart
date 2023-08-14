import 'package:appcommerce/notfi/det_screen.dart';
import 'package:appcommerce/screens/chat/chatscreen.dart';
import 'package:appcommerce/screens/cart/cart_screen.dart';
import 'package:appcommerce/screens/complete_profile/complete_profile_screen.dart';
import 'package:appcommerce/screens/details/details_screen.dart';
import 'package:appcommerce/screens/favorite/favoritescreen.dart';
import 'package:appcommerce/screens/forgot_password/forgot_password_screen.dart';
import 'package:appcommerce/screens/home/home_screen.dart';
import 'package:appcommerce/screens/jomla/cartjomla/cartjomla.dart';
import 'package:appcommerce/screens/login_success/login_success_screen.dart';
import 'package:appcommerce/screens/offers/oferscreen.dart';
import 'package:appcommerce/screens/profile/lang_screen.dart';
import 'package:appcommerce/screens/profile/profile_screen.dart';
import 'package:appcommerce/screens/sign_in/google/google_sign.dart';
import 'package:appcommerce/screens/sign_in/sign_in_screen.dart';
import 'package:appcommerce/screens/splash/firstpage.dart';
import 'package:appcommerce/screens/splash/splash_screen.dart';
import 'package:appcommerce/screens/splash/secondpage.dart';
import 'package:flutter/widgets.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'changescreen.dart';

// We use name route
// All our routes will be available here

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  //OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ChangeScreen.routeName: (context) => ChangeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  Cartjomla.routeNamee: (context) => Cartjomla(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  Favscreen.routeName:(context) => Favscreen(),
  Chatscreen.routeName:(context) => Chatscreen(),
  GoogleSignIn.routeName:(context) => GoogleSignIn(),
  DetScreen.routeName:(context) =>DetScreen(),
  Offerscreen.routeName:(context)=>Offerscreen(),
  LangScreen.routeName:(context)=>LangScreen(),
  Firstpage.routeName:(context)=>Firstpage(),
  Secondpage.routeName:(context)=>Secondpage(),


};
