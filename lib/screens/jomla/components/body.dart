import 'package:appcommerce/screens/jomla/components/categories.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'home_header.dart';
import 'popular_product.dart';
class Body extends StatelessWidget {
  String aa;
  Body(this.aa);





  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(

      child: SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
          //  DiscountBanner(),
            SizedBox(height: getProportionateScreenWidth(10)),
            SizedBox(height: getProportionateScreenWidth(10)),
            SizedBox(height: getProportionateScreenWidth(10)),
            Categories(aa),
          //  SpecialOffers(),

            SizedBox(height: getProportionateScreenWidth(10)),
            //PopularProducts(aa),
            //SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
