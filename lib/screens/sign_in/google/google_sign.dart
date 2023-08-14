import 'package:appcommerce/screens/home/home_screen.dart';
import 'package:appcommerce/screens/sign_in/google/service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class GoogleSignIn extends StatefulWidget {
  static String routeName = "/sign_in google";
  GoogleSignIn({Key key}) : super(key: key);

  @override
  _GoogleSignInState createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return !isLoading ? SizedBox(
      width: size.width * 0.8,
      child: OutlinedButton.icon(
        icon: FaIcon(FontAwesomeIcons.google),
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          FirebaseService service = new FirebaseService();
          try {
            await service.signInwithGoogle();
            Navigator.pushNamed(context, HomeScreen.routeName);
          } catch (e) {
            print(e);
            /*if (e is FirebaseAuthException) {
              showMessage(e.message);
            }*/
          }
          setState(() {
            isLoading = false;
          });
        },
        label: Text(
          'تسجيل الدخول بحساب كوكل',
          style: TextStyle(
              color: Colors.pink, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.white),
            side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
      ),
    ) : Center(child:CircularProgressIndicator() ,);
  }
  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}