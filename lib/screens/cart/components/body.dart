import 'package:appcommerce/models/Cart.dart';
import 'package:appcommerce/provider/cart.dart';
import 'package:appcommerce/provider/categor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
class Body extends StatefulWidget {
  List<Cart> list;
  String msg;
  Body();




  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  String uid;
  Future<String> getUID() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;
    return uid;
  }


  Future<List<Cart>> get_cart(context){
    return Provider.of<Carts>(context,listen: false).getCart();
  }
  void get_cartinfo(context){
    return Provider.of<Carts>(context,listen: false).getinfo();
  }
  @override
  void initState() {

    getUID();

    if (widget.list==0){

    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      get_cart(context);
      get_cartinfo(context);
    });

    super.initState();

  }
  void remov_notif(context,index){
    return Provider.of<Categors>(context,listen: false).removenotifitem(index);
  }
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
        () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<Carts>(
        builder: (context, cart, child) {
          return FutureBuilder(
              future: FirebaseDatabase.instance.reference().child('Product').child('mfrd').once(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if(cart.citem==null){
                    return Center(
                      child:Padding(
                        padding:
                        EdgeInsets.only(top: 60),
                        child: Text('السلة فارغة',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize:20),
                        ),
                      ),

                    );
                  }else{
                    return Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                      child: ListView.builder(
                        itemCount: cart.item.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Dismissible(
                            key: Key(cart.item[index].productid),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction)async{
                                    await FirebaseDatabase.instance.reference()
                                    .child('Users/$uid/cart/').child('${cart.item[index].ke}/').remove();
                                    remov_notif(context, 0);
                                    cart.removecartpriceindexx(cart.sum - cart.item[index].price);
                                    cart.removeindex(index);

                            },
                            background: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFE6E6),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  SvgPicture.asset("assets/icons/Trash.svg"),
                                ],
                              ),
                            ),
                            child: CartCard(index:index),
                          ),
                        ),
                      ),
                    );
                  }

                }
                else {
                  return Center(
                    child: CircularProgressIndicator(color: Color(0xFFFF0036),),
                    //
                  );

                }
              }
          );
        });


  }
}
