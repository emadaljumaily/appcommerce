import 'package:appcommerce/components/cardj.dart';
import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/models/Dataj.dart';
import 'package:appcommerce/provider/categor.dart';
import 'package:appcommerce/provider/products.dart';
import 'package:appcommerce/provider/productsj.dart';
import 'package:appcommerce/screens/jomla/components/popular_product.dart';
import 'package:appcommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
class Categories extends StatefulWidget {
  String aa;

  Categories(this.aa);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {


 // List<String> categories = ["الكل", "ساعات","اجهزة","حقائب","احذية","ملابس"];
  // By default our first item will be selected
  int selectedIndex = 0;

  void get_categors(context,String ff){
    return Provider.of<Categors>(context,listen: false).catsecond(ff);
  }
  void selectedd(context,item){
    return Provider.of<Servicess>(context,listen: false).selectindexx(item);
  }


  Future<List<Dataj>> getsecond(context,type){
    return Provider.of<Servicess>(context,listen: false).getPostssec(type);
  }
  Future<List<Dataj>> getmain(context,type){
    return Provider.of<Servicess>(context,listen: false).getPostssecp(type);
  }
  void insertItem(context,Dataj item){
    return Provider.of<Servicess>(context,listen: false).add(item);
  }
  Future<List<Dataj>> get_list_productssp(context,type){
    return Provider.of<Servicess>(context,listen: false).getPostssec(type);
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      get_list_productssp(context, widget.aa);
      get_categors(context, widget.aa);
      selectedd(context, 0);
    });
    super.initState();
  }
  String masg='';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<Categors>(
        builder: (context, cart, child) {
          return FutureBuilder(
              future:FirebaseDatabase.instance.reference().child("Product").child('jomla').once(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if(cart.item.length != null){
                    return Column(
                      children: [

                        Padding(

                          child: SizedBox(

                            height: 60,
                            child: ListView.builder(
                              //reverse: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: cart.item.length,
                              itemBuilder: (context, index) => buildCategory(index),
                            ),

                          ),

                          padding:
                          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),

                        ),

                        SizedBox(height: getProportionateScreenWidth(15)),
                        SizedBox(height: getProportionateScreenWidth(20)),
                        Container(
                          // height:300,
                          width: 380,
                          child: productwidget(context),

                        ),






                      ],
                    );
                  }else{
                    return Column(children: [Container()],);

                  }

                }
                else {
                  return CircularProgressIndicator(color: Color(0xFFFF0036),);
                }
              }
          );

        });
    /*return Padding(

      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(

        height: 50,
        child: ListView.builder(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );*/
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
                  return Center(child: CircularProgressIndicator(color: Color(0xFFFF0036),),);
                }
              }
          );
        });

  }
 changeCategors(String fs){

    DatabaseReference ref=FirebaseDatabase.instance.reference().child("Product").child('jomla');
    ref.once().then((DataSnapshot datasnapshot){
      var keys=datasnapshot.value.keys;
      var values=datasnapshot.value;
      for(var key in keys) {
        if(values[key]["type"]=="${widget.aa}" && values[key]["types"]=="${fs}" ){
          Dataj datae = new Dataj(
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
          insertItem(context, datae) ;
        }else{

        }
      }
      productwidget(context);

    });



  }

  Widget buildCategory(int index) {
    List<String> aa=Provider.of<Categors>(context).item;
    List<String> aaa=Provider.of<Categors>(context).itemse;
    String ind=Provider.of<Servicess>(context).index;
    return GestureDetector(
      onTap: () {
        //setState(() {
        // removecat(context);
        print(aaa[index]);
        selectedd(context, index);
        if(aaa[index].contains('الكل')){
          get_list_productssp(context, widget.aa);
          //checkb(context);
          // allProduct();

        }else{
          getsecond(context, aaa[index]);


          changeCategors(aaa[index]);
          //checkw(context);
          //get_categors(context, aa[index]);

        }


        //  });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Container(
              padding: EdgeInsets.only(left: 5.0),
              child:  Consumer<Servicess>(
                  builder: (context, cart, child) {
                    return Text(

                      aaa[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily:"beIN",
                        color: cart.indexxx == index ? Color(0xFFF11241) : Colors.black,
                        //  backgroundColor: selectedIndex == index ? Color(0x34FF0036) : Colors.transparent,
                      ),
                      textAlign: TextAlign.center,

                    );
                  }),

            ),
            Consumer<Servicess>(
                builder: (context, cart, child) {
                  return Container(
                    margin: EdgeInsets.only(top: 10.0 / 4), //top padding 5
                    height: 2,
                    width: 50,
                    color: cart.indexxx == index ? Colors.black : Colors
                        .transparent,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
