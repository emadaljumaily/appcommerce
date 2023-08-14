import 'package:appcommerce/models/Cart.dart';
import 'package:appcommerce/provider/cart.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:provider/provider.dart';
class CartCard extends StatefulWidget {
  //final Cart cart;
 final int index;
  const CartCard({
    Key key,
    this.index,
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
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.network(Provider.of<Carts>(context).item[widget.index].image),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${Provider.of<Carts>(context).item[widget.index].title}',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      maxLines: 2,
                    ),
                    SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        text: "${Provider.of<Carts>(context).item[widget.index].price}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: kPrimaryColor),
                        children: [
                          TextSpan(
                              text: " x${Provider.of<Carts>(context).item[widget.index].number}",
                              style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                    )
                  ],
                )
              ],
            );


  }
}
