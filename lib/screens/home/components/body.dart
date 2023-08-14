import 'dart:async';
import 'package:appcommerce/models/offers.dart';
import 'package:appcommerce/provider/categor.dart';
import 'package:appcommerce/provider/offer_products.dart';
import 'package:appcommerce/provider/products.dart';
import 'package:appcommerce/screens/home/components/popular_product.dart';
import 'package:appcommerce/screens/home/components/search_field.dart';
import 'package:appcommerce/screens/home/components/special_offers.dart';
import 'package:intl/intl.dart';
import 'package:appcommerce/components/cardd.dart';
import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/notfi/det_screen.dart';
import 'package:appcommerce/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../changescreen.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'discount_banner.dart';
import 'icon_btn_with_counter.dart';
import 'package:provider/provider.dart';


class notf{
  String tit;
  notf(this.tit);
}

 class Body extends StatefulWidget {

   Body({
     Key key
   }) : super(key: key);
   @override
   _bdy createState()=> _bdy();
}
class _bdy extends State<Body>{

  String masg='';
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _textFieldController = TextEditingController();
  bool _validate = false;
  String msg='';

  String uid;
  List<notf>lst=[];
  int cout=0;
  void delnotif()async{
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;

    final reff =  FirebaseDatabase.instance.reference().child("Users/notif/${uid}");
    reff.once().then((DataSnapshot datasnapshot) {
      if (datasnapshot.value == null) {
        // print('no data');

      } else {
        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys){
          final date2 = DateTime.now();
          DateFormat inputFormat = DateFormat('yyyy/MM/dd');
          DateTime input = inputFormat.parse(values[key]['date']);
          final difference = date2.difference(input).inDays;
          if(difference >=2){
            FirebaseDatabase.instance.reference().child("Users/notif/${uid}").remove();
          }
          print(difference);
        }

      }
    });
  }
  void notfi() async{
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;
    final ref =  FirebaseDatabase.instance.reference().child("Users/notif/${uid}");
    ref.once().then((DataSnapshot datasnapshot){
      if(datasnapshot.value == null)
      {
       // print('no data');

      }else{

        lst.clear();
        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys){
          notf da=new notf(
            values[key]['title'],

          );

          lst.add(da);



            if(lst.isNotEmpty){
              cout=1;
            }

          print('yyyyyy $cout');
        }
      }


      setState(() {


      });

    });

  }

  Dataa _dataa;
  void insertItem(context,Dataa item){
    return Provider.of<Services>(context,listen: false).add(item);
  }
  void mmsg(context,String item){
    return Provider.of<Services>(context,listen: false).insItem(item);
  }
  void removall(context){
    return Provider.of<Services>(context,listen: false).removall();
  }
  void selected(context,item){
    return Provider.of<Services>(context,listen: false).selectindex(item);
  }
  void selectedd(context,item){
    return Provider.of<Services>(context,listen: false).selectindexx(item);
  }
  void selecte(context,item){
    return Provider.of<Services>(context,listen: false).selecte(item);
  }
  Future<List<Dataa>> get_list_products(context){
    return Provider.of<Services>(context,listen: false).getPosts();
  }
  Future<List<Dataa>> get_list_productssp(context,type){
    return Provider.of<Services>(context,listen: false).getPostss(type);
  }
  Future<List<Offer>> get_list_offer(context){
    return Provider.of<Provideroffer>(context,listen: false).ofer();
  }
  void removallf(context){
    return Provider.of<Provideroffer>(context,listen: false).removall();
  }
  void removecat(context){
    return Provider.of<Categors>(context,listen: false).removallsec();
  }
  void removecate(context){
    return Provider.of<Categors>(context,listen: false).removalllsec();
  }

  void get_categores(context){
    return Provider.of<Categors>(context,listen: false).cat();
  }
  void get_categors(context,String ff){
    return Provider.of<Categors>(context,listen: false).catsecond(ff);
  }
  Future get_notif(context){
    return Provider.of<Categors>(context,listen: false).notifCart();
  }
  bool checkk(context){
    return Provider.of<Categors>(context,listen: false).wdg;
  }
  void checkw(context){
    return Provider.of<Categors>(context,listen: false).checkw();
  }
  void checkb(context){
    return Provider.of<Categors>(context,listen: false).checkb();
  }



  @override
  void initState() {

    delnotif();
     notfi();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      get_list_products(context);
      get_list_offer(context);
      get_categores(context);
      removecat(context);
      removecate(context);
      checkb(context);
      get_notif(context);
      selected(context, 0);

    });
    print("check : ${checkk(context)}");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(

      child: SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
           // Homeheader(),
            //Headr
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SearchField(),
          /*Container(
          width: SizeConfig.screenWidth * 0.5,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              onChanged: (value) =>serchfield(value),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(25),
                      vertical: getProportionateScreenWidth(1)),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "بـحـث......",

                  hintStyle: TextStyle(fontSize: 20,fontFamily: "beIN",color: Colors.black38), // you need this
                  //hintTextDirection: TextDirection.rtl,
                  prefixIcon: Icon(Icons.search)),
            ),
          ),*/
              SizedBox(width: getProportionateScreenWidth(2)),
              IconBtnWithCounter(
                svgSrc: "assets/icons/Lock.svg",
                press: ()=>Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new ChangeScreen())
                ),
                ),
              SizedBox(width: getProportionateScreenWidth(2)),
            Consumer<Categors>(
                builder: (context, cart, child) {
                  return IconBtnWithCounter(
                    svgSrc: "assets/icons/Cart Icon.svg",
                    press: () => Navigator.pushNamed(context, CartScreen.routeName),
                    numOfitem: cart.lis_notif.length,
                  );
                }),
              SizedBox(width: getProportionateScreenWidth(2)),
              IconBtnWithCounter(
                svgSrc: "assets/icons/Bell.svg",
                numOfitem: cout,
                //press: () => Navigator.pushNamed(context, DetScreen.routeName),
                press: ()=>Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new DetScreen())
                ),
              ),
            ],
          ),
        ),
            SizedBox(height: getProportionateScreenWidth(10)),
            DiscountBanner(),
            SizedBox(height: getProportionateScreenWidth(10)),
            //Categories(),


       Column(
          children: [
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40)),
              child: Text('عروض خاصة',style: TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily:"beIN",)),


              /*child: SectionTitle(
                title: 'عروض خاصة',

                press: () {},
              ),*/
            ),
            SizedBox(height: getProportionateScreenWidth(20)),
     Consumer<Provideroffer>(
    builder: (context, cart, child) {
      if(cart.list_offerf.isEmpty){
        return Row(
            children: <Widget>[

]
        );
      }else{
        return Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 130.0,
                child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cart.ff.length,
                  padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
                  itemBuilder: (BuildContext ctxt, int index) {
                    return new SpecialOfferCard(
                      ff:cart.ff[index],
                      ima: cart.itemf[index],
                    );
                  },
                ),
              ),
            ),

          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
      }

    }),



          ]
      ),


            //SpecialOffers(off: off),






            SizedBox(height: getProportionateScreenWidth(30)),
          //  PopularProducts(),
         Consumer<Categors>(
    builder: (context, cart, child) {
     return FutureBuilder(
          future:FirebaseDatabase.instance.reference().child("Product").child('mfrd').once(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if(masg != null){
                return Column(
                  children: [

                    Padding(

                      child: SizedBox(

                        height: 50,
                        child: ListView.builder(
                          //reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: cart.item.length,
                          itemBuilder: (context, index) => buildCategory(index),
                        ),

                      ),

                      padding:
                      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),

                    ),

                    SizedBox(height: getProportionateScreenWidth(15)),
                    checkk(context)==false?Row():Padding(
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                          //reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: cart.itemse.length,
                          itemBuilder: (context, index) => buildCategorys(index),
                        ),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                    ),
                    SizedBox(height: getProportionateScreenWidth(20)),
                    Container(
                      // height:300,
                      width: 380,
                      child: productwidget(context),

                    ),





                  ],
                );
              }else if(masg ==null){
                return Center(
                  child:Padding(
                    padding:
                    EdgeInsets.only(top: 60),
                    child: Text('لا توجد منتجات ',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.red),
                    ),
                  ),

                );
              }else{

              }

            }
            else {
              return CircularProgressIndicator(color: Color(0xFFFF0036),);
            }
          }
      );

    }),
            SizedBox(height: getProportionateScreenWidth(20)),

          ],
        ),
      ),
    );
  }
  changeCategor(String ff){
    removall(context);
    DatabaseReference ref=FirebaseDatabase.instance.reference().child("Product").child('mfrd');
    ref.once().then((DataSnapshot datasnapshot){
      var keys=datasnapshot.value.keys;
      var values=datasnapshot.value;
      for(var key in keys) {
        if(values[key]["type"]=="${ff}"){
          Dataa datae = new Dataa(
            values[key]['id'],
            values[key]['title'],
            values[key]['description'],
            values[key]["image"],
            values[key]["color"],
            values[key]['price'],
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
  changeCategors(String ff,String fs){
    removall(context);
    DatabaseReference ref=FirebaseDatabase.instance.reference().child("Product").child('mfrd');
    ref.once().then((DataSnapshot datasnapshot){
      var keys=datasnapshot.value.keys;
      var values=datasnapshot.value;
      for(var key in keys) {
        if(values[key]["type"]=="${ff}" && values[key]["types"]=="${fs}" ){
          Dataa datae = new Dataa(
            values[key]['id'],
            values[key]['title'],
            values[key]['description'],
            values[key]["image"],
            values[key]["color"],
            values[key]['price'],
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
    return GestureDetector(
      onTap: () {
        //setState(() {
          selected(context, index);
          removecat(context);
          removecate(context);
          if(aa[index].contains('الكل')){
            get_list_products(context);
            checkb(context);
            print("check : ${checkk(context)}");
          // allProduct();

          }else{

            get_categors(context, aa[index]);
            changeCategor(aa[index]);
            selecte(context, aa[index]);
            checkw(context);

            
            print("check : ${checkk(context)}");
          }


      //  });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Container(
              padding: EdgeInsets.only(left: 5.0),
              child:  Consumer<Services>(
          builder: (context, cart, child) {
            return Text(

              "${aa[index]}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily:"beIN",
                color: cart.indexx == index ? Color(0xFFF11241) : Colors.black,
                //  backgroundColor: selectedIndex == index ? Color(0x34FF0036) : Colors.transparent,
              ),
              textAlign: TextAlign.center,

            );
          }),

            ),
         Consumer<Services>(
            builder: (context, cart, child) {
              return Container(
                margin: EdgeInsets.only(top: 10.0 / 4), //top padding 5
                height: 2,
                width: 50,
                color: cart.indexx == index ? Colors.black : Colors
                    .transparent,
              );
            }),
          ],
        ),
      ),
    );
  }
  Widget buildCategorys(int index) {
    List<String> aa=Provider.of<Categors>(context).item;
    List<String> aaa=Provider.of<Categors>(context).itemse;
    String ind=Provider.of<Services>(context).index;
    return GestureDetector(
      onTap: () {
        //setState(() {
       // removecat(context);
        //removecate(context);
        selectedd(context, index);
        if(aa[index].contains('الكل')){
          get_list_productssp(context,ind);
          //checkb(context);
          // allProduct();

        }else{
          //removecat(context);
          changeCategors(ind,aaa[index]);
          //checkw(context);
          get_categors(context, aa[index]);

        }


        //  });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Container(
              padding: EdgeInsets.only(left: 5.0),
              child:  Consumer<Services>(
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
            Consumer<Services>(
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
  Widget productwidget(BuildContext context){
    return Consumer<Services>(
      builder: (context, cart, child) {
        return FutureBuilder(
           future:FirebaseDatabase.instance.reference().child("Product").child('mfrd').once(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {

                if(cart.p_Item==null){
                  return Center(
                    child:Padding(
                      padding:
                      EdgeInsets.only(top: 60),
                      child: Text('لاتوجد منتجات ',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.red),
                      ),
                    ),

                  );
                }else{
                  print('ok :');

                  return Padding(

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

                        itemBuilder: (context, index) => Cardd(
                          product: cart.items[index],
                          index:index,




                        )
                    ),
                  );
                }

              }
              else {
                return Center(child:CircularProgressIndicator(color: Color(0xFFFF0036),));
              }
            }
        );

      },
   );

  }
  void serchfield(String value){
  removall(context);
   DatabaseReference ref=FirebaseDatabase.instance.reference().child("Product").child('mfrd');
      ref.once().then((DataSnapshot datasnapshot){

        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys) {

          _dataa = new Dataa(
            values[key]['id'],
            values[key]['title'],
            values[key]['description'],
            values[key]["image"],
            values[key]["color"],
            values[key]['price'],
            values[key]['size'],
            values[key]['rating'],
            values[key]['isFavourite'],
            values[key]['isPopular'],
            values[key]['type'],

          );
          if(_dataa.title.contains(value)){
            insertItem(context, _dataa);
          }else{
          }
          Timer(Duration(seconds: 1),(){
            setState(() {
              //
              productwidget(context);
            });
          });

        }
      });

  }

}
