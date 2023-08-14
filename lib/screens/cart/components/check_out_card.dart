import 'package:appcommerce/errordialog.dart';
import 'package:appcommerce/localization/languages/languages.dart';
import 'package:appcommerce/models/Cart.dart';
import 'package:appcommerce/provider/cart.dart';
import 'package:appcommerce/provider/categor.dart';
import 'package:appcommerce/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appcommerce/components/default_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../custom_progress_dialog.dart';
import '../../../dialog.dart';
import '../../../size_config.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class CheckoutCard extends StatefulWidget {
  /*final Cart cart;
  final List<Cart> list;
  final int total;
  final String phone;
  final String address;*/
  const CheckoutCard({
    Key key,


  }) : super(key: key);
  @override
  _CheckoutCard createState() => _CheckoutCard();
}


class _CheckoutCard extends State<CheckoutCard> {
  ProgressDialog _progressDialog=new ProgressDialog();
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  /*void aa() {
    for (int i = 0; i < widget.list.length; i++) {
      print('eeee ${widget.list[i].productid}');
    }
  }*/
  void remov_notif(context){
    return Provider.of<Categors>(context,listen: false).removenotif();
  }
  @override
  void initState() {


    super.initState();
  //  aa();

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
                    text: ":السعر الكلي \n",
                    children: [
                      TextSpan(
                        //text: "\$337.15",
                        text:'IQ ${Provider.of<Carts>(context).totalsum}',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: Languages.of(context).buy,
                    press: () {
                     // _progressDialog.showProgressDialog(context,textToBeDisplayed: 'شراء...',dismissAfter: Duration(seconds: 5));
                      String msg='';
                      String ms='';
                      if( Provider.of<Carts>(context).phone== 'لايوجد'){
                        msg=' اضافة رقم الهاتف';
                      }if(Provider.of<Carts>(context).address == 'لايوجد'){
                        ms='اضافة العنوان';
                      }
                      if(Provider.of<Carts>(context).phone=='لايوجد' ||Provider.of<Carts>(context).total =='لايوجد'){
                        showDialog(context: context,
                            builder: (BuildContext context){
                              return ErrorDialogBox(
                                title: "خطأ",
                                descriptions: "$msg \n $ms",
                                text: "حسنا",
                              );
                            }
                        );

                      }else{
                        setState(() {
                          by();
                        });
                        remov_notif(context);
                        showDialog(context: context,
                            builder: (BuildContext context){
                              return CustomDialogBox(
                                title: "",
                                descriptions: "تمت عملية الشراء",
                                text: "حسنا",
                              );
                            }
                        );
                      }


                     // _progressDialog.dismissProgressDialog(context);
                    /*  setState(() {
                        by();
                      });
                      showDialog(context: context,
                          builder: (BuildContext context){
                            return CustomDialogBox(
                              title: "",
                              descriptions: "تمت عملية الشراء",
                              text: "حسنا",
                            );
                          }
                      );*/
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
    dynamic size = new List<String>();
    int number;
    for (int i = 0; i < Provider.of<Carts>(context).item.length; i++) {
   title=Provider.of<Carts>(context).item[i].title;
   price=Provider.of<Carts>(context).item[i].price;
   image=Provider.of<Carts>(context).item[i].image;
   color=Provider.of<Carts>(context).item[i].color;
   number=Provider.of<Carts>(context).item[i].number;
   size=Provider.of<Carts>(context).item[i].size;
   final FirebaseUser user = await firebaseAuth.currentUser();
   String uid = user.uid;
   final ref = FirebaseDatabase.instance.reference().child('Request');
   ref.child(uid).push().set({
     'title':title,
     'price':price,
     'image':image,
     'color':color,
     'number':number,
     'date':formattedDate,
     'size':size

   });
    }
    final FirebaseUser user = await firebaseAuth.currentUser();
    String uid = user.uid;
    final ref = await FirebaseDatabase.instance.reference().child('Users').child(uid);
    ref.child('cart').remove();

  }

}
