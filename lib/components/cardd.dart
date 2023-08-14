
import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/provider/productdetails.dart';
import 'package:appcommerce/provider/products.dart';
import 'package:appcommerce/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';
import '../dialog.dart';
import '../size_config.dart';
import 'package:provider/provider.dart';
class Cardd extends StatefulWidget {
  final double width, aspectRetio;
  final Dataa product;
 final int index;
  final bool toggle;
  final FirebaseAuth firebaseAuth;
  const Cardd({
    Key key,
    this.index,
    this.width = 140,
    this.aspectRetio = 1.02,
    this.product,
    this.toggle = false,
    this.firebaseAuth, String id, String title, image, int price,
  }) : super(key: key);
  @override
  _Cardd createState() => _Cardd();
}
class Fav{
  dynamic fav = new List<String>();

  Fav(this.fav);
}
class _Cardd extends State<Cardd> {
bool isfav=false;
final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
List<Fav>listfav=[];
Fav _fav;
void getfav() async {

  final FirebaseUser user = await firebaseAuth.currentUser();
  final uid = user.uid;
  final ref = FirebaseDatabase.instance.reference().child('Product').child('mfrd');
  ref.child(widget.product.id).child('userfav').child(uid).once().then((DataSnapshot snapShot){
    if(snapShot.value == null)
    {
      //  print('no data');
      isfav=false;

    }else {

      setState(() {
        isfav=true;
      });
    }
  });
}
void insertItem(context){
  return Provider.of<Services>(context,listen: false).reseCounter();
}
Future<List<listprod>> addproduct(context,String ff){
  return Provider.of<Productdetails>(context,listen: false).getproduct(ff);
}
List<Productdetails>sd=[];
@override
  void initState() {
  /*WidgetsBinding.instance.addPostFrameCallback((_) {
    insertItem(context);
  });*/
    getfav();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<Services>(
        builder: (context, cart, child) {
          return Container(

            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border(
                top: BorderSide(width: 1.0, color: Color(0xDFF0036)),
                left: BorderSide(width: 1.0, color: Color(0xDFF0036)),
                right: BorderSide(width: 1.0, color: Color(0xDFF0036)),
                bottom: BorderSide(width: 1.0, color: Color(0xDFF0036)),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0xDFF0036),
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.75)
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(0)),
              child: SizedBox(
                width: getProportionateScreenWidth(widget.width),
                child: GestureDetector(
                  onTap: (){
                    addproduct(context, widget.product.id);
                    insertItem(context);
                      Navigator.pushNamed(
                        context,
                        DetailsScreen.routeName,
                        arguments: ProductDetailsArguments(product: widget.product,index: widget.index),
                      );},
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1.10,


                        child: Container(
                          width: 20,
                          padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                          decoration: BoxDecoration(
                            color: kSecondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),


                          ),
                          child: Hero(
                            tag: widget.product.id.toString(),
                            child: Image.network(widget.product.image[0]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.product.title,
                        style: TextStyle(color: Colors.black),
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\IQ${widget.product.price}",

                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(16),
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              setState(() {

                                if(isfav==false){
                                  isfav=true;
                                  print('ok');
                                  writeData();
                                }else{
                                  isfav=false;
                                  print('noo');
                                  delData();
                                }
                              });


                            },
                            child: Container(
                              padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                              height: getProportionateScreenWidth(28),
                              width: getProportionateScreenWidth(28),
                              decoration: BoxDecoration(

                                color:isfav? kPrimaryColor.withOpacity(0.15): kSecondaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/Heart Icon_2.svg",
                                color: isfav? Color(0xFFFF4848): Color(0xFFDBDEE4),
                                //color: widget.fav.fav ==null ?Color(0xFFDBDEE4):widget.fav.fav ==true? Color(0xFFFF4848): Color(0xFFDBDEE4),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );

        });
  }

  void writeData() async {
    dynamic userfav = new List<String>();
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;
    userfav=uid;
    final ref = FirebaseDatabase.instance.reference().child('Product').child('mfrd');
    String key=ref.push().key;
    ref.child('${widget.product.id}/').child('userfav').child(uid).update({
      'userfav':uid,
    });
    final reff = FirebaseDatabase.instance.reference().child('Users').child(uid).child('favorite');
    reff.child(widget.product.id).set({
      'id':widget.product.id,
      'title':widget.product.title,
      'price':widget.product.price,
      "image":widget.product.image[0],
      'color':widget.product.colors,

    });
    showDialog(context: context,
        builder: (BuildContext context){
          return CustomDialogBox(
            title: "",
            descriptions: "تمت أضافة المنتج الى المفظلة",
            text: "Ok",
          );
        }
    );
  }
void delData() async {

  final FirebaseUser user = await firebaseAuth.currentUser();
  final uid = user.uid;
  final ref = FirebaseDatabase.instance.reference().child('Users/');
  ref.child(uid).child('/favorite').child(widget.product.id).remove();
  final reff = FirebaseDatabase.instance.reference().child('Product').child('mfrd');
  reff.child(widget.product.id).child('userfav').child(uid).remove();
}


}
