import 'package:appcommerce/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/components/coustom_bottom_nav_bar.dart';
import 'package:appcommerce/enums.dart';


import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../size_config.dart';
import 'components/body.dart';

class Notif{
  String title;
  int price;
  String image;
  Notif({
    this.title,
    this.image,
    this.price,});
dynamic tojson()=>{

  'title': title,
  'image': image,
  'price': price,
};
  factory Notif.fromJson(Map<dynamic, dynamic> json) {
    return Notif(
      title: json['title'],
      image: json['image'],
      price: json['price'],

    );
  }
  }
class DetScreen extends StatefulWidget {
  static String routeName = "/notification";
@override
  _fvo createState() => _fvo();
}
  class _fvo extends State<DetScreen>{
  String msg='';
  List<Notif> listf=[];
  Notif cartfav;

  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  Future<Notif> geta() async{
    listf.clear();
    final FirebaseUser user = await firebaseAuth.currentUser();
     String uid = user.uid;
    final ref = await FirebaseDatabase.instance.reference().child("Users/").child('notif');
    ref.child(uid).once().then((DataSnapshot datasnapshot){

      Map<dynamic, dynamic> values = datasnapshot.value;
      if(datasnapshot.value == null)
      {
        // print('no data');
        msg=datasnapshot.value;

      }else{
      //  msg='good';
        values.forEach((key, values) {
          listf.add(Notif.fromJson(values));
        });
      }

      setState(() {

      });

    });

  }
  @override
  void initState() {
   geta();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar:buildAppBar(context),
      body: Body(listf,msg),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "الاشعارات",
            style: TextStyle(color: Colors.black,fontFamily:"beIN"),
          ),

        ],
      ),
    );
  }
}