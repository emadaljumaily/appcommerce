import 'package:appcommerce/models/offers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import '../size_config.dart';
class Offers extends StatefulWidget {
  final Offer off;
  final FirebaseAuth firebaseAuth;
  const Offers({
    Key key,
    this.off,
    this.firebaseAuth,
  }) : super(key: key);
  @override
  _Cardd createState() => _Cardd();
}
class Fav{
  dynamic fav = new List<String>();

  Fav(this.fav);
}
class _Cardd extends State<Offers> {
final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;


@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
        width: getProportionateScreenWidth(55),
        child: GestureDetector(
          /*onTap: ()=>
              Navigator.pushNamed(
                context,
                DetailsScreen.routeName,
                arguments: ProductDetailsArguments(product: widget.product),
              ),*/
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
                    tag: widget.off.type.toString(),
                     child: Image.network(widget.off.image[0]),
                  ),
                ),
              ),
              const SizedBox(height: 10),

            ],
          ),
        ),
      ),
    ),
    );
  }



}
