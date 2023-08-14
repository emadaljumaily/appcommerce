import 'package:appcommerce/models/offers.dart';
import 'package:appcommerce/screens/offers/oferscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
   SpecialOffers({
    Key key,
  }) : super(key: key);
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

              return Column(
                children: [
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(80)),
                    child: SectionTitle(
                      title: "Special for you",
                      press: () {},
                    ),
                  ),
                  SizedBox(height: getProportionateScreenWidth(20)),
                  /* Container(
                     child:             ListView.builder(
                       reverse: true,
                       scrollDirection: Axis.horizontal,
                       itemCount: off.length,
                       itemBuilder: (context, index) => SpecialOfferCard(off: off[index
                       ]),
                     ) ,
                   ),*/

                  /*SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [



                       /* SpecialOfferCard(
                          image: 'assets/images/shoes2.png',
                          category: 'kjhkjh',
                          numOfBrands: 18,
                          press: () {},
                        ),
                        SpecialOfferCard(
                          image: 'assets/images/shoes2.png',
                          category: 'kjhkjh',
                          numOfBrands: 18,
                          press: () {},
                        ),*/

                        SizedBox(width: getProportionateScreenWidth(20)),
                      ],
                    ),
                  ),*/
                ],
              );


  }


}


class SpecialOfferCard extends StatelessWidget {
 final String ff;
 final Offer ima;
  const SpecialOfferCard({
    this.ff,
    this.ima,
    Key key,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: ()=>Navigator.pushNamed(
          context,
          Offerscreen.routeName,
          arguments: ProductofferArguments(type:ff),


        ),

        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(

              children: [

            Padding(
            padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(40.0),
            vertical: getProportionateScreenWidth(10),
          ),
          child:Image.network(
                  ima.image[0],
                  fit: BoxFit.cover,
                ),),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xDFF0036).withOpacity(0.4),
                        Color(0xDFF0036).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "${ff}\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
