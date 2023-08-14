import 'package:appcommerce/models/Dataj.dart';
import 'package:flutter/material.dart';
import '../../../../size_config.dart';
import 'colord.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget{
  final Dataj product;

  Body({Key key,  this.product}) : super(key: key);
  @override
  Sa createState() => Sa();
}
class Sa extends State<Body> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                   // ColorDots(product: product),
                    Colords(product: widget.product),
                   // CartCounter(),
                  /*  TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),

                        ),

                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () {

                          //  writeData();
                            print('${widget.aa}');

                          },
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
