import 'package:appcommerce/models/Dataj.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class JDetailsScreen extends StatelessWidget {
  //static String routeName = "/details";
  final Dataj dat;

  JDetailsScreen({ this.dat});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: dat.rating),
      ),
      body: Body(product: dat),
    );
  }
}

