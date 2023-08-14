import 'package:appcommerce/models/Cart.dart';
import 'package:appcommerce/screens/favorite/favoritescreen.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
class CartCard extends StatefulWidget {
 // final Notif cart;
final String msg;
  const CartCard({
    this.msg,
    Key key,

  }) : super(key: key);

  //final Cart cart;
  @override
  CartCardd createState() => CartCardd();
}

class CartCardd extends State<CartCard> {
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  String uid;
  String name;

  Future<String > geta() async{
    final FirebaseUser user = await firebaseAuth.currentUser();
    String uid = user.uid;
    final ref = await FirebaseDatabase.instance.reference().child("Users/").child(uid);
    ref.once().then((DataSnapshot datasnapshot){

      name=datasnapshot.value['Name'];

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
            return Column(
              children: [
                Row(

                  children: [
                    Container(
                      decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(10),

                      ),

                      child:Text(
                          ' اكتمال الطلب بنجاح',
                          style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold, fontSize: 18),
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          ),
                    ),


                  ],
                ),


                //SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      ' ${name } عزيزي ''  \n .تم اكمال طلبك وسيتم ايصال الطلب  في اقرب وقت        \n شكرا لاختيارك سندباد بغداد ',
                      style: TextStyle(color: Colors.black54,fontWeight:FontWeight.normal, fontSize: 16),

                      maxLines: 10,
                      textAlign: TextAlign.right,
                    ),
                  ],
                )

              ],
            );


  }
}
