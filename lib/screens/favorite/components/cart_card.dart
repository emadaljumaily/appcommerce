import 'package:appcommerce/screens/favorite/favoritescreen.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatefulWidget {
  final Cartfav cart;
  const CartCard({
    Key key,
    this.cart,
  }) : super(key: key);

  //final Cart cart;
  @override
  CartCardd createState() => CartCardd();
}
class CartCardd extends State<CartCard> {


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
            return Row(
              children: [
                SizedBox(
                  width: 88,
                  child: AspectRatio(
                    aspectRatio: 0.88,
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.network(widget.cart.image),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.cart.title}',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      maxLines: 2,
                    ),
                    SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        text: "${widget.cart.price}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: kPrimaryColor),
                        children: [

                        ],
                      ),
                    )
                  ],
                )
              ],
            );


  }
}
