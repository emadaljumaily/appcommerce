import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/provider/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';
import '../../../dialog.dart';
import '../../../size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
class ProductDescription extends StatefulWidget {
  final Dataa product;
  final GestureTapCallback pressOnSeeMore;
  const ProductDescription({
    Key key,
    this.product,
    this.pressOnSeeMore,
  }) : super(key: key);
     @override
  _desc createState() => _desc();


}
class _desc extends State<ProductDescription>{
  bool isfav=false;
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
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
  @override
  void initState() {
   getfav();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final pr = Provider.of<Productdetails>(context).llist;
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            pr[0].title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {

              if(isfav==false){
                isfav=true;
                print('ok');
                writeData();
              }else{
                setState(() {
                  isfav=false;
                  print('noo');
                  delData();
                });

              }
            });


          },
          child:Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              width: getProportionateScreenWidth(64),
              decoration: BoxDecoration(
                color:
                isfav ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: SvgPicture.asset(
                "assets/icons/Heart Icon_2.svg",
                color:
                isfav ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                height: getProportionateScreenWidth(16),
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            pr[0].description,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "${pr[0].price} IQ",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                SizedBox(width: 5),

              ],
            ),
          ),
        )
      ],
    );
  }
  void writeData() async {
   // dynamic userfav = new List<String>();
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;
   // userfav=uid;
    final ref = FirebaseDatabase.instance.reference().child('Product').child('mfrd');
    //String key=ref.push().key;
    ref.child(widget.product.id).child('userfav').child(uid).update({
      'userfav':uid,
    });
    final reff = FirebaseDatabase.instance.reference().child('Users/$uid/favorite');
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
