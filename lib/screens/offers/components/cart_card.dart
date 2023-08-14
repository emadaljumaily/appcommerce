import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CartCar extends StatefulWidget {
  final Dataa cart;
  const CartCar({
    Key key,
    this.cart,
  }) : super(key: key);

  //final Cart cart;
  @override
  CartCardd createState() => CartCardd();
}
class CartCardd extends State<CartCar> {


  @override
  Widget build(BuildContext context) {
            SizeConfig().init(context);
            return  InkWell(
              onTap: (){
                Navigator.pushNamed(
                  context,
                  DetailsScreen.routeName,
                  arguments: ProductDetailsArguments(product: widget.cart),
                );
              },
             child:Container(
              // color: Colors.green,
                width: getProportionateScreenWidth(320),

                child:Row(
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(80),
                      child: AspectRatio(
                        aspectRatio: 0.88,
                        child: Container(
                          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.network(widget.cart.image[0]),
                        ),
                      ),
                    ),
                    SizedBox(width: getProportionateScreenWidth(30)),
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
                    ),

]
    ),
              )
    );




  }
}
