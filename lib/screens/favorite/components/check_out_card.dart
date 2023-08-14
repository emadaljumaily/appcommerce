import 'package:appcommerce/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appcommerce/components/default_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../custom_progress_dialog.dart';
import '../../../size_config.dart';
import 'package:intl/intl.dart';

class CheckoutCard extends StatefulWidget {
  final Cart cart;
  final List<Cart> list;
  final int total;
  const CheckoutCard(this.total,this.list, {
    Key key,
    this.cart,

  }) : super(key: key);
  @override
  _CheckoutCard createState() => _CheckoutCard();
}


class _CheckoutCard extends State<CheckoutCard> {
  ProgressDialog _progressDialog=new ProgressDialog();
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  void aa() {
    for (int i = 0; i < widget.list.length; i++) {
      print('eeee ${widget.list[i].productid}');
    }
  }

  @override
  void initState() {


    super.initState();
    aa();

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                /*Text("Add voucher code"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )*/
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        //text: "\$337.15",
                        text:'IQ ${widget.total}',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "اكمال عملية الشراء",
                    press: () {
                      _progressDialog.showProgressDialog(context,textToBeDisplayed: 'شراء...',dismissAfter: Duration(seconds: 5));
                      by();

                      _progressDialog.dismissProgressDialog(context);
                      setState(() {

                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void by() async{
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy/MM/dd hh:mm:ss").add_jm().format(now);


    String title;
    int price;
    String image;
    dynamic color = new List<int>();
    int number;
    for (int i = 0; i < widget.list.length; i++) {
   title=widget.list[i].title;
   price=widget.list[i].price;
   image=widget.list[i].image;
   color=widget.list[i].color;
   number=widget.list[i].number;
   final FirebaseUser user = await firebaseAuth.currentUser();
   String uid = user.uid;
   final ref = FirebaseDatabase.instance.reference().child('Request');
   ref.child(uid).push().set({
     'title':title,
     'price':price,
     'image':image,
     'color':color,
     'number':number,
     'date':formattedDate

   });
    }
    final FirebaseUser user = await firebaseAuth.currentUser();
    String uid = user.uid;
    final ref = await FirebaseDatabase.instance.reference().child('Users').child(uid);
    ref.child('cart').remove();

  }

}
