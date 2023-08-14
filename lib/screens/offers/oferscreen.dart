
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../size_config.dart';
import 'components/body.dart';

class Cartofer{
  String id,title;
  int price;
  dynamic image = new List<String>();
  Cartofer( this.id,
    this.title,
    this.image,
    this.price);
dynamic tojson()=>{
  'id':id,
  'title': title,
  'image': image,
  'price': price,
};
 /* factory Cartofer.fromJson(Map<dynamic, dynamic> json) {
    return Cartofer(
      id:json['id'],
      title: json['title'],
      image: json['image'][0],
      price: json['price'],

    );
  }*/
  }
class Offerscreen extends StatelessWidget {

  static String routeName = "/ofer";

  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final ProductofferArguments agrs =ModalRoute.of(context).settings.arguments as ProductofferArguments ;

    return Scaffold(
     appBar: buildAppBar(context),
      body: Body(type:agrs.type),

    );
  }

}
class ProductofferArguments {
  final String type;

  ProductofferArguments({ this.type});
}
AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: Column(
      children: [
        Text(
          "العروض",
          style: TextStyle(color: Colors.black,fontFamily:"beIN"),
        ),

      ],
    ),
  );
}