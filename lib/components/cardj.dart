import 'package:appcommerce/models/Dataj.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import '../size_config.dart';
import 'package:appcommerce/screens/jomla/jdetails/jdetails_screen.dart';
class Cardj extends StatefulWidget {
  final double width, aspectRetio;
  final Dataj product;
  final bool toggle;
  final FirebaseAuth firebaseAuth;
  const Cardj({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    this.product,
    this.toggle = false,
    this.firebaseAuth,
  }) : super(key: key);
  @override
  _Cardj createState() => _Cardj();
}

class _Cardj extends State<Cardj> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(widget.width),
        child: GestureDetector(
          onTap: ()=>
              /*Navigator.pushNamed(
                context,
                JDetailsScreen.routeName,
                arguments: JomlaDetailsArguments(product: widget.product),
              ),*/
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JDetailsScreen(dat: widget.product,),
            ),
          ),

          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(

                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
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
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {

                    },
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(

                        color: widget.product.isFavourite
                            ? kPrimaryColor.withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: widget.product.isFavourite
                            ? Color(0xFFFF4848)
                            : Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void writeData() async {
    final ref = FirebaseDatabase.instance.reference().child('Users/');
    final FirebaseUser user = await widget.firebaseAuth.currentUser();
    final uid = user.uid;

    ref.child('rsuE8uTQazgAdlns9QSFinIlvxf2/favorite').set({
    });
  }
}
