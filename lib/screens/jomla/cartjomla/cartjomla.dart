

import 'package:flutter/material.dart';
import 'package:appcommerce/models/Cartj.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appcommerce/screens/jomla/cartjomla/componentcart/check_out_cardj.dart';
import 'package:appcommerce/screens/jomla/cartjomla/componentcart/bodyj.dart';
class Cartjomla extends StatefulWidget {
  static String routeNamee = "/cart";
  @override
  _CartScreenj createState() => _CartScreenj();
}

class _CartScreenj extends State<Cartjomla> {
  var sum = 0;
  var total=0;
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;

  List<Cartj> list=[];
   String uid;

  Future<String> getUID() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;

  }
  String masg='';
    Future<String> getData() async{
      final FirebaseUser user = await firebaseAuth.currentUser();
      uid = user.uid;
    print(uid);
    final ref =  FirebaseDatabase.instance.reference().child("Users/${uid}/jomla");
    ref.once().then((DataSnapshot datasnapshot){
      if(datasnapshot.value == null)
      {
        masg=datasnapshot.value;
        print(masg);

      }else{
        list.clear();
        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys){
          Cartj dat=new Cartj(
            values[key]['productid'],
            values[key]['title'],
            values[key]['price'],
            values[key]['number'],
            values[key]["image"],
            values[key]["id"],
            values[key]['color'],
            values[key]['size'],

          );

          //print(datasnapshot.value);
          //sum += values[key]['price'].;
          //final sum = list.sum;
          list.add(dat);
          //list.length;
        }
        for (var i = 0; i < list.length; i++) {
          //sum += list[i];
          sum +=list[i].price * list[i].number;
          // int hh=list[i].;

        }
        total = list.where((c) => c.number == c.number).toList().length;
      }

      setState(() {

      });

    });

  }


  @override
  void initState() {
    super.initState();

      getUID();
      getData();

  }

  @override
  Widget build(BuildContext context) {

            return Scaffold(
              appBar: buildAppBarr(context),
              body: Bodycart(list,masg),
              bottomNavigationBar: CheckoutCardj(sum,list),
            );

        }




  AppBar buildAppBarr(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "السلة",
            style: TextStyle(color: Colors.black,fontFamily:"beIN"),
          ),
          Text(
            "${total}: العدد ",
          //  "items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
