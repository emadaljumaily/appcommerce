import 'package:appcommerce/components/cardd.dart';
import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/provider/productdetails.dart';
import 'package:appcommerce/provider/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appcommerce/constants.dart';

import '../../../size_config.dart';
import 'package:provider/provider.dart';

import '../details_screen.dart';
import 'body.dart';
class Customchangeproduct extends StatefulWidget {
  List<getid> list=[];
  Dataa product;
  Customchangeproduct(this.list, this.product);
  @override
  Saa createState() => Saa();
}
class Saa extends State<Customchangeproduct> {
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  void insertItem(context){
    return Provider.of<Services>(context,listen: false).incrementCounter();
  }
  void minitem(context){
    return Provider.of<Services>(context,listen: false).incrementCountermin();
  }
  int updatec(context){
    return Provider.of<Services>(context,listen: false).getCounter;
  }
  Future getproduct(context,String ff){
    return Provider.of<Productdetails>(context,listen: false).getproduct(ff);
  }
  Dataa product;
  List<getid> ll=[];
  int i=0;
  Color ch = Color(0xFFFF0036);
  Color chd = Colors.grey;
  bool chh=false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
        child: Row(
          children: [
         Consumer<Services>(
        builder: (context, cart, child) {
          if (cart.itemm.length>1){
            return SizedBox(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  primary: kPrimaryColor,
                  backgroundColor: Colors.white54,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {

                 if(cart.llist.length == updatec(context)){

                 }else{
                   insertItem(context);
                   getproduct(context, cart.llist[updatec(context)].id);
                 }
                  //  Navigator.pop(context);





                }
                ,
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
             
                ),
              ),
            );
          }else{

          }

        }),
           /* SizedBox(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  primary: kPrimaryColor,
                  backgroundColor: Colors.white54,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                           Dataa product;
                    if(i<widget.list.length) {
                   print("kjhjkhjhkjh : ${widget.list[i++].id}");
                   Navigator.pushNamed(
                     context,
                     DetailsScreen.routeName,
                     arguments: ProductDetailsArguments(product: product),
                   );


                    }else{

                    }


    }
                ,
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
                ),
              ),
            ),*/
            Spacer(),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Consumer<Services>(
                  builder: (context, cart, child) {
                    if (cart.itemm.length>1){
                      return SizedBox(
                        height: getProportionateScreenWidth(40),
                        width: getProportionateScreenWidth(40),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            primary: kPrimaryColor,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: (){



                            if(cart.llist.length <= updatec(context) &&updatec(context)<0){


                            }else

                              minitem(context);
                            getproduct(context, cart.llist[updatec(context)].id);


                            },


                          child: SvgPicture.asset(
                            "assets/icons/Next icon.svg",
                            height: 15,

                          ),
                        ),
                      );
                    }else{

                    }

                  }),
              /*child: SizedBox(
                height: getProportionateScreenWidth(40),
                width: getProportionateScreenWidth(40),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    primary: kPrimaryColor,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: (){
                    if(i >0) {
                      print("kjhjkhjhkjh : ${widget.list[i--].id}");



                    }else{

                    }

                  },
                  child: SvgPicture.asset(
                    "assets/icons/Next icon.svg",
                    height: 15,
                  ),
                ),
              ),*/
             /* child: Row(
                children: [
                  Text(
                    "${rating}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset("assets/icons/Star Icon.svg"),
                ],
              ),*/
            )
          ],
        ),
      ),
    );
  }
}
