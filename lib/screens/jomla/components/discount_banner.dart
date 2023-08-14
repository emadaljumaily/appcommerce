import 'package:flutter/material.dart';

import '../../../size_config.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,

      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(15)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(10),
      ),
      decoration: BoxDecoration(
        color: Color(0xFFEF103F),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Text.rich(

        TextSpan(
          style: TextStyle(color: Colors.white),

          children: [
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(1, 10, 180, 0),

              ),
            ),
            TextSpan(text: "تخفيظات\n",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontFamily:"beIN",
    fontWeight: FontWeight.bold,
    color: Colors.white),
            ),
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(1, 10, 100, 0),

              ),
            ),
            TextSpan(
              text: " %تصل الى 20",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
                fontFamily:"beIN",
              ),
            ),
          ],
        ),

      ),
    );
  }
}
