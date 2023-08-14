import 'dart:async';

import 'package:appcommerce/components/default_button.dart';
import 'package:appcommerce/components/rounded_icon_btn.dart';
import 'package:appcommerce/localization/languages/languages.dart';
import 'package:appcommerce/models/Dataj.dart';
import 'package:appcommerce/provider/categor.dart';
import 'package:appcommerce/screens/jomla/jdetails/components/top_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../constants.dart';
import '../../../../custom_progress_dialog.dart';
import '../../../../dialog.dart';
import '../../../../errordialog.dart';
import '../../../../size_config.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Colords extends StatefulWidget{
  final Dataj product;

   Colords({Key key,this.product}) : super(key: key);
  @override
  Colr createState() => Colr();
}
class Colr extends State<Colords> {
  final storage=new FlutterSecureStorage();
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  ProgressDialog _progressDialog=new ProgressDialog();
  int numOfItems = 1;
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
        () => 'Data Loaded',
  );
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      restnum(context);
      restclick(context);
    });
    super.initState();
  }
  void addnum(context){
    return Provider.of<Categors>(context,listen: false).addnumj();
  }
  void minnum(context){
    return Provider.of<Categors>(context,listen: false).minnumj();
  }
  int getnum(context){
    return Provider.of<Categors>(context,listen: false).numOfItemsj;
  }
  void restnum(context){
    return Provider.of<Categors>(context,listen: false).numj();
  }



  void click(context){
    return Provider.of<Categors>(context,listen: false).clicked();
  }

  void restclick(context){
    return Provider.of<Categors>(context,listen: false).restclick();
  }
  int getclick(context){
    return Provider.of<Categors>(context,listen: false).click;
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),

       child:Column(
         children:[   Row(
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             FutureBuilder(
               future: FirebaseDatabase.instance.reference().child("Product").child('jomla').once(),
               builder: (ctx,snapshot){
                 if (snapshot.connectionState == ConnectionState.done) {
                   if(widget.product.size ==null){
                     return Row(

                     );
                   }else{
                     return Column(
                       children: [
                         Row(
                           children: [
                             Text('أختر الحجم',
                               style: TextStyle(fontSize: 16,fontFamily: 'BeIn'),

                             )
                           ],
                         ),

                         Row(
                           children: [
                             ...List.generate(widget.product.size.length,
                                   (index) =>  Textsizej(
                                 size:widget.product.size[index],
                               ),

                             ),
                           ],
                         )
                       ],
                     );



                     /*List.generate(widget.product.size.length,
                         (index) => Textsize(
                           size:widget.product.size[index],
                         ),
                          );*/
                   }
                 }else{
                   return Center(child: CircularProgressIndicator(),);
                 }
               },
             ),

           ],
         ),



      ],
    ),
           Row(children: [
             Column(children: [
               Text('أختر اللون',
                 style: TextStyle(fontSize: 16,fontFamily: 'BeIn'),

               ),
               Row(
                 children: [
                   FutureBuilder(
                     future: FirebaseDatabase.instance.reference().child("Product").child('jomla').once(),
                     builder: (ctx,snapshot){
                       if (snapshot.connectionState == ConnectionState.done) {
                         if(widget.product.colors ==null){
                           return Row(

                           );
                         }else{
                           return Column(
                             children: [

                               Row(
                                 children: [
                                   ...List.generate(
                                     widget.product.colors.length,
                                         (index) => ColorDott(
                                       color: widget.product.colors[index],
                                       //  isSelected: index == selectedColor,

                                       count:index ,

                                     ),
                                   ),
                                 ],
                               )
                             ],
                           );

                         }
                       }else{
                         return Center(child: CircularProgressIndicator(),);
                       }
                     },
                   ),

                 ],
               )
             ],

             ),
             Spacer(),
             RoundedIconBtn(
               icon: Icons.remove,
               press: () {
                 if (Provider.of<Categors>(context,listen: false).numOfItemsj == 1) {
                   /*setState(() {
              numOfItems--;
            });*/
                 }else{
                   minnum(context);

                 }
               },
             ),
             //SizedBox(width: getProportionateScreenWidth(7)),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0 / 2),
               child:Consumer<Categors>(
                   builder:(context, cart, child){
                     return Text(
                       cart.numOfItemsj.toString().padLeft(2, "0"),
                       style: Theme.of(context).textTheme.headline6,
                     );
                   }
               ),
             ),
             RoundedIconBtn(
               icon: Icons.add,
               showShadow: true,
               press: () {
                 addnum(context);
               },
             ),
           ],
           ),
   // Expanded(),
    Row(
      children: [
       Expanded(
         child:TopRoundedContainer(
           color: Colors.white,
           child: Padding(
             padding: EdgeInsets.only(
               left: SizeConfig.screenWidth * 0.15,
               right: SizeConfig.screenWidth * 0.15,
               bottom: getProportionateScreenWidth(40),
               top: getProportionateScreenWidth(15),

             ),
           child: Consumer<Categors>(
               builder:(context, cart, child){
                 return cart.click==1?Center(child: CircularProgressIndicator(color: Color(0xFFFF0036),),):
                 DefaultButton(
                   text: Languages.of(context).cart,
                   press: ()async{


                   buy();

                   },
                 );

               }
           ),
           /*child:getclick(context)==1?Center(child: CircularProgressIndicator(color: Color(0xFFFF0036),),):
           DefaultButton(
             text: Languages.of(context).cart,
             press: ()async{
              click(context);
             },
           ),*/
             /*child: DefaultButton(
               text: Languages.of(context).cart,
               press: ()async{
                 setState(() {


                 });

               },
             ),*/
           ),
         ),
       )
      ],
    ),
         ]
       ),
    );
  }

  void buy() async{
    click(context);
    if(widget.product.type.contains('ملابس') || widget.product.type.contains('احذية') ){
      if(lsize.isNotEmpty && clp.isNotEmpty) {
        final DateTime now = DateTime.now();
        final DateFormat formatter = DateFormat('yyyyMMddHms');
        final String formatted = formatter.format(now);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final ref = FirebaseDatabase.instance.reference().child('Users');
        final FirebaseUser user = await firebaseAuth.currentUser();
        final uid = user.uid;

        ref.child(uid+"/jomla/${formatted}").set({
          'productid':widget.product.id,
          'title':widget.product.title,
          'image':await storage.read(key: 'immj'),
          'number':getnum(context),
          'price':widget.product.price,
          'id':formatted,
          'color':clp,
          'size':lsize

        });
        restclick(context);
        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialogBox(
                title: "",
                descriptions: "تمت أضافته الى السلة",
                text: "Ok",
              );
            }
        );

      }else{
        restclick(context);
        showDialog(context: context,
            builder: (BuildContext context){
              return ErrorDialogBox(
                title: "خطأ",
                descriptions: "اختيار اللون او الحجم",
                text: "حسناً",
              );
            }
        );
      }
      }else if(widget.product.type.contains('مفاتيح')){
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyyMMddHms');
      final String formatted = formatter.format(now);
     // SharedPreferences prefs = await SharedPreferences.getInstance();
      final ref = FirebaseDatabase.instance.reference().child('Users');
      final FirebaseUser user = await firebaseAuth.currentUser();
      final uid = user.uid;

      ref.child(uid+"/jomla/${formatted}").set({
        'productid':widget.product.id,
        'title':widget.product.title,
        'image':await storage.read(key: 'immj'),
       // 'image':'ghgh',
        'number':getnum(context),
        'price':widget.product.price,
        'id':formatted,
        'color':clp,
        'size':lsize

      });
      restclick(context);
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialogBox(
              title: "",
              descriptions: "تمت أضافته الى السلة",
              text: "Ok",
            );
          }
      );
    }



  clp.clear();
  lsize.clear();

  }

}
class Textsizej extends StatefulWidget{
  String size;
  Textsizej({Key key,  this.size,}) : super(key: key);
  @override
  text createState()=>text();
}
List<String>lsize=[];
class text extends State<Textsizej>{
  bool hidtext = false;
  void toggle(){
    setState(() {
      hidtext=!hidtext;
    });

  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        setState(() {
          toggle();
          if(hidtext==true){
            lsize.add(widget.size);
            print(lsize);
          }else{
            lsize.remove(widget.size);
            print(lsize);
          }
        });
      },

      child: Container(
        margin: EdgeInsets.only(right: 4),
        padding: EdgeInsets.all(getProportionateScreenWidth(2)),
        height: getProportionateScreenWidth(25),
        width: getProportionateScreenWidth(25),
        decoration: BoxDecoration(
          color: hidtext ? Colors.white : Colors.transparent,
          border:
          Border.all(color: hidtext ? Color(0xFFFF0036) : Colors.black54),
          shape: BoxShape.circle,
        ),
        child: Text(

          widget.size,textAlign: TextAlign.center,
        ),
      ),

    );
  }
}

class ColorDott extends StatefulWidget{
   int color;
   bool isSelected;
   int count;
   ColorDott({Key key,  this.color,
    this.isSelected = false,
    this.count}) : super(key: key);
  @override
  Colre createState() => Colre();


}
List<int>clp=[];
class Colre extends State<ColorDott> {
  String message = "Hello";
  bool hidtext = false;
  void _toggle(){
    setState(() {
      hidtext=!hidtext;
    });

  }

  @override
  Widget build(BuildContext context) {
    final Color colorr  = Color(widget.color).withOpacity(1);
    int a=widget.count;
//clp.clear();
    return InkWell(
        onTap: () {

         // setValue();

  message = "Bye";

  _toggle();
  if(hidtext==true){
    clp.add(widget.color);
    print(clp);


  }else{
    clp.remove(widget.color);

  }







        },

             child: Container(
                margin: EdgeInsets.only(right: 2),
                padding: EdgeInsets.all(getProportionateScreenWidth(3)),
                height: getProportionateScreenWidth(30),
                width: getProportionateScreenWidth(30),
                decoration: BoxDecoration(
                  color: hidtext ? Colors.white : Colors.transparent,
                  border:
                  Border.all(color: hidtext ? kPrimaryColor : Colors.black),
                  shape: BoxShape.circle,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorr,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

          );


      /*child: Container(
          margin: EdgeInsets.only(right: 2),
          padding: EdgeInsets.all(getProportionateScreenWidth(8)),
          height: getProportionateScreenWidth(40),
          width: getProportionateScreenWidth(40),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border:
            Border.all(color: hidtext ? kPrimaryColor : Colors.transparent),
            shape: BoxShape.circle,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colorr,
              shape: BoxShape.circle,
            ),
          ),
        ),*/



  }

}
