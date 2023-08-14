import 'package:appcommerce/components/cardj.dart';
import 'package:appcommerce/constants.dart';
import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/models/Dataj.dart';
import 'package:appcommerce/provider/categor.dart';
import 'package:appcommerce/provider/productsj.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../size_config.dart';
import '../../../constants.dart';
class PopularProducts extends StatefulWidget {

String aa;
PopularProducts(this.aa);


  @override
  _NeedsState createState() => _NeedsState();
}

class _NeedsState extends State<PopularProducts> {

  int selectedIndex = 0;
  List<Dataj> lista=[];
  String masg='';
  Future<List<Dataj>> get_list_productssp(context,type){
    return Provider.of<Servicess>(context,listen: false).getPostssec(type);
  }
  void removall(context){
    return Provider.of<Servicess>(context,listen: false).removall();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //removall(context);
      get_list_productssp(context, widget.aa);

    });
  /*  print('gooooooooooooooooooooood ${widget.aa}');
    Query ref=FirebaseDatabase.instance.reference().child("Product").child('jomla').orderByChild("type").equalTo(widget.aa);

    ref.once().then((DataSnapshot datasnapshot){
      if(datasnapshot.value == null)
      {
        masg=datasnapshot.value;
        print(masg);

      }else{
       
        lista.clear();
        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys){
          Dataj data=new Dataj(
            values[key]['id'],
            values[key]['title'],
            values[key]['description'],
            values[key]["image"],
            values[key]["color"],
            values[key]['pricej'],
            values[key]['size'],
            values[key]['rating'],
            values[key]['isFavourite'],
            values[key]['isPopular'],
            values[key]['type'],


          );
          lista.add(data);


        }
      }


      setState(() {
        //
      });
    });*/

  }

  double height;
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
        () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    height = MediaQuery.of(context).size.height;
   /* return Consumer<Servicess>(
        builder: (context, cart, child) {
          return FutureBuilder(
              future:FirebaseDatabase.instance.reference().child("Product").child('jomla').once(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (cart.p_Item != null) {
                    return Column(
                      children: [
                        Padding(
                          child: SizedBox(
                            height: 1,

                          ),

                          padding:
                          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
                        ),
                        SizedBox(height: getProportionateScreenWidth(30)),
                        Container( height: MediaQuery.of(context).size.height,
                          //  width: 400,
                          padding: EdgeInsets.only(right: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Padding(

                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: GridView.builder(
                                      itemCount: cart.itemm.length,
                                      primary: false,

                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15.0,
                                        crossAxisSpacing: kDefaultPaddin,
                                        childAspectRatio: 0.75,
                                      ),

                                      itemBuilder: (context, index) => Cardj(
                                        product: cart.items[index],
                                        /* press: () => Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => DetailsScreen(
                                     product: products[index],
                                   ),
                                 )
                             ),*/
                                      )),
                                ),
                              ),

                            ],
                          ),

                        ),





                      ],
                    );
                  } else {

                    return Center(
                      child:Padding(
                        padding:
                        EdgeInsets.only(top: 60),
                        child: Text('لاتوجد منتجات ',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.red),
                        ),
                      ),

                    );
                  }
                }
                else {
                  return CircularProgressIndicator(color: Color(0xFFFF0036),);
                }
              }
          );
        });*/
productwidget(context);

  }

  Widget productwidget(BuildContext context){
    return Consumer<Servicess>(
        builder: (context, cart, child) {
          return FutureBuilder(
              future:FirebaseDatabase.instance.reference().child("Product").child('jomla').once(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (cart.p_Item != null) {
                    return Column(
                      children: [
                        Padding(
                          child: SizedBox(
                            height: 1,

                          ),

                          padding:
                          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
                        ),
                        SizedBox(height: getProportionateScreenWidth(30)),
                        Container( height: MediaQuery.of(context).size.height,
                          //  width: 400,
                          padding: EdgeInsets.only(right: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Padding(

                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: GridView.builder(
                                      itemCount: cart.itemm.length,
                                      primary: false,

                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15.0,
                                        crossAxisSpacing: kDefaultPaddin,
                                        childAspectRatio: 0.75,
                                      ),

                                      itemBuilder: (context, index) => Cardj(
                                        product: cart.items[index],
                                        /* press: () => Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => DetailsScreen(
                                     product: products[index],
                                   ),
                                 )
                             ),*/
                                      )),
                                ),
                              ),

                            ],
                          ),

                        ),





                      ],
                    );
                  } else {

                    return Center(
                      child:Padding(
                        padding:
                        EdgeInsets.only(top: 60),
                        child: Text('لاتوجد منتجات ',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.red),
                        ),
                      ),

                    );
                  }
                }
                else {
                  return CircularProgressIndicator(color: Color(0xFFFF0036),);
                }
              }
          );
        });

  }


  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {

                

        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            /*Container(
              padding: EdgeInsets.only(left: 5.0),
              child:Text(

                categories[index],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily:"beIN",
                  color: selectedIndex == index ? Color(0xFFF11241) : Colors.black,
                  //  backgroundColor: selectedIndex == index ? Color(0x34FF0036) : Colors.transparent,
                ),
                textAlign: TextAlign.center,

              ),

            ),
          */
            Container(
              margin: EdgeInsets.only(top: 10.0 / 4), //top padding 5
              height: 2,
              width: 50,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
  Widget CardUI(String id, String title, String description, String image, String price) {
    return Card(
      //padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(140),
        child: GestureDetector(
          onTap: ()=> print("")/*
              Navigator.pushNamed(
                context,
                DetailsScreen.routeName,
                arguments: ProductDetailsArguments(product: product),
              )*/,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(

                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),

                  ),
                  child: Hero(
                    tag: id.toString(),
                    child: Image.asset(image),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "${title}",
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${price}",

                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {

                    },
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(

                        /*color: product.isFavourite
                            ? kPrimaryColor.withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),*/
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        /* color: product.isFavourite
                            ? Color(0xFFFF4848)
                            : Color(0xFFDBDEE4),*/
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

  }
}
