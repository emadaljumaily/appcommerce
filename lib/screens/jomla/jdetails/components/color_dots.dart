import 'package:appcommerce/models/Data.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/components/rounded_icon_btn.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
class ColorDots extends StatefulWidget{
  final Dataa product;

  const ColorDots({Key key,  this.product}) : super(key: key);
  @override
  Colr createState() => Colr();


}
class Colr extends State<ColorDots> {

  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo

    int selectedColor = 3;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            widget.product.colors.length,
            (index) => ColorDot(

              color: widget.product.colors[index],
              isSelected: index == selectedColor,

            ),
          ),
          SizedBox(width: getProportionateScreenWidth(35)),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
    if (numOfItems > 1) {
      setState(() {
        numOfItems--;
      });
    }
            },
          ),
          SizedBox(width: getProportionateScreenWidth(7)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0 / 2),
            child: Text(
             // '$numOfItems'
              // if our item is less  then 10 then  it shows 01 02 like that
              numOfItems.toString().padLeft(2, "0"),

              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(7)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              setState(() {
                numOfItems++;
              });

             /* showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text("gfgfgfhgfh"),
                      actions: [
                        FlatButton(
                          child: Text("Ok"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
*/


            },
          ),
        ],
      ),
    );
  }

}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key key,
     this.color,
    this.isSelected = false,

  }) : super(key: key);
final int color;

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final Color colorr  = Color(color).withOpacity(1);
    return Container(
      margin: EdgeInsets.only(right: 1),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryGradientColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(

          color:colorr,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

}
