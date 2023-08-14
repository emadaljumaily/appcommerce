

import 'package:appcommerce/provider/cart.dart';
import 'package:appcommerce/provider/categor.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/models/Cart.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
class CartScreen extends StatefulWidget {
  static String routeName = "/cartt";
  @override
  _CartScreen createState() => _CartScreen();
}
class Inf{
  String phon;
  String address;
  Inf(this.phon, this.address);

  }

class _CartScreen extends State<CartScreen> {
  var sum = 0;
  var total=0;
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
String msg='';
  List<Cart> list=[];
   String uid;
List<Inf> listinfo=[];
  Future<String> getUIDD() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;
     return uid;
  }
  String phone;
  String addres;
  void getinfo()async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;
    final ref = FirebaseDatabase.instance.reference().child("Users/$uid/");
    listinfo.clear();
    ref.once().then((DataSnapshot datasnapshot) {
      if (datasnapshot.value == null) {
        // print('no data');
       // msg = datasnapshot.value;
      } else {

        var keys = datasnapshot.value.keys;
        var values = datasnapshot.value;
        for (var key in keys) {
          Inf inf = new Inf(
            values[key]["phone"],
            values[key]['Address'],
          );
          listinfo.add(inf);

        }
        for(int i=0;i<listinfo.length;i++){
          phone=listinfo[i].phon as String;
          addres=listinfo[i].address;
        }

      }
      setState(() {

      });
    });
  }

    void getDataa() async{
      final FirebaseUser user = await firebaseAuth.currentUser();
      uid = user.uid;
      final ref =  FirebaseDatabase.instance.reference().child("Users/$uid/cart");

      ref.once().then((DataSnapshot datasnapshot){
        if(datasnapshot.value == null)
        {
          // print('no data');
          msg=datasnapshot.value;

        }else{
          list.clear();
          var keys=datasnapshot.value.keys;
          var values=datasnapshot.value;
          for(var key in keys){
            Cart dat=new Cart(
              values[key]['productid'],
              values[key]['title'],
              values[key]['price'],
              values[key]['number'],
              values[key]["image"],
              values[key]['id'],
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

    //getinfo();
      getUIDD();
      //getDataa();


  }

  @override
  Widget build(BuildContext context) {

            return Scaffold(
              appBar: buildAppBar(context),
              //body: Body(list,msg),
              body: Body(),
             // bottomNavigationBar: CheckoutCard(sum,list,phone,addres),
              bottomNavigationBar: CheckoutCard(),
            );
          }




  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "السلة",
            style: TextStyle(color: Colors.black,fontFamily:"beIN"),
          ),
          Text(
            "${Provider.of<Categors>(context).lis_notif.length}: العدد ",
          //  "items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
