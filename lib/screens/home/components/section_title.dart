import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
     this.title,
     this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: press,
          child: Text(
            "  ",
            style: TextStyle(color: Colors.black54,fontFamily:"beIN",fontSize: getProportionateScreenWidth(16),
              fontWeight: FontWeight.bold,

            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
            fontFamily:"beIN",
            fontWeight: FontWeight.bold,

          ),
        ),

      ],
    );
  }
}
