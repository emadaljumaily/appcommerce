
import 'package:flutter/material.dart';
import '../../size_config.dart';
import 'components/body.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:appcommerce/models/typee.dart';
class JomlaScreen extends StatelessWidget {
  static String routeName = "/jomla";
   String aa;
  JomlaScreen(this.aa);

  Future<String> getUID() async {

  }
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return FutureBuilder(
        future: getUID(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Body(aa),
              // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
            );
          }
          else {
            return CircularProgressIndicator();
          }
        }
    );

  }


}
