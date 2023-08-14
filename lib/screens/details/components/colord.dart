import 'package:appcommerce/components/default_button.dart';
import 'package:appcommerce/components/rounded_icon_btn.dart';
import 'package:appcommerce/dialog.dart';
import 'package:appcommerce/localization/languages/languages.dart';
import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/provider/categor.dart';
import 'package:appcommerce/provider/productdetails.dart';
import 'package:appcommerce/screens/details/components/top_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../custom_progress_dialog.dart';
import '../../../errordialog.dart';
import '../../../size_config.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Colords extends StatefulWidget{
  final Dataa product;

   Colords({Key key,this.product}) : super(key: key);
  @override
  Colr createState() => Colr();
}
class Colr extends State<Colords> {
  final storage=new FlutterSecureStorage();
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  ProgressDialog _progressDialog=new ProgressDialog();
  int numOfItems = 1;


  String dropdownsize='اختر الحجم';
  var itemsize =  ['اختر الحجم'];
  List<String>ff=[];
  void dd()async{
itemsize.add(widget.product.size);
  }
  void cat() async{

    final ref =  FirebaseDatabase.instance.reference().child("Product").child('mfrd');
    ref.once().then((DataSnapshot datasnapshot){
      if(datasnapshot.value == null){

      }else{

        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys) {
          if(values[key]["type"]=="ملابس"){
            itemsize.add(values[key]['size']);
          }else if(values[key]["type"]=="احذية"){
            itemsize.add(values[key]['size']);
          }else{

          }


        }

        setState(() {


        });
      }




    });

  }
  void addnotif(context,item){
    return Provider.of<Categors>(context,listen: false).addnotif(item);
  }
  List<String> itemsizee=[];
  void restnum(context){
    return Provider.of<Categors>(context,listen: false).num();
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      restnum(context);
    });
      //cat();

    print(widget.product.size);

    super.initState();
  }

  void addnum(context){
    return Provider.of<Categors>(context,listen: false).addnum();
  }
  void minnum(context){
    return Provider.of<Categors>(context,listen: false).minnum();
  }
  int getnum(context){
    return Provider.of<Categors>(context,listen: false).numOfItems;
  }

  @override
  Widget build(BuildContext context) {
        //int  a=widget.product.id;
    final pr = Provider.of<Productdetails>(context).llist;

    SizeConfig().init(context);
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),

       child:Column(

         children:[
           Row(
             children: [


               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   FutureBuilder(
                     future: FirebaseDatabase.instance.reference().child('Product').child('mfrd').once(),
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
                                 Text(Languages.of(context).size,
                                   style: TextStyle(fontSize: 16,fontFamily: 'BeIn'),

                                 )
                               ],
                             ),

                             Row(
                               children: [
                                 ...List.generate(pr[0].size.length,
                                       (index) =>  Textsize(
                                     size:pr[0].size[index],
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
                       return Center(child: CircularProgressIndicator(color: Color(0xFFFF0036),),);
                     }
                     },
                   ),
                  /* ...List.generate(widget.product.size.length,
                           (index) =>  Textsize(
                             size:widget.product.size[index],
                           ),

                   ),*/
                 ],
               )

           ],
           ),
           Row(
       children: [

         Column(
           children: [
             Text(Languages.of(context).color,
               style: TextStyle(fontSize: 16,fontFamily: 'BeIn'),

             ),
             Row(children: [
               FutureBuilder(
                 future: FirebaseDatabase.instance.reference().child('Product').child('mfrd').once(),
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
                                 pr[0].colors.length,
                                     (index) => ColorDott(
                                   color: pr[0].colors[index],
                                   count:index ,

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
                     return Center(child: CircularProgressIndicator(color: Color(0xFFFF0036),),);
                   }
                 },
               ),

             ],),
           ],
         ),






      Spacer(),
      RoundedIconBtn(
        icon: Icons.remove,
        press: () {
          if (Provider.of<Categors>(context,listen: false).numOfItems == 1) {
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
              cart.numOfItems.toString().padLeft(2, "0"),
              style: Theme.of(context).textTheme.headline6,
            );
          }
        ), /*Text(
          Provider.of<Categors>(context).numOfItems.toString().padLeft(2, "0"),
          style: Theme.of(context).textTheme.headline6,
        ),*/
      ),
      RoundedIconBtn(
        icon: Icons.add,
        showShadow: true,
        press: () {
          addnum(context);
          /*setState(() {
            numOfItems++;
          });*/
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

             child: DefaultButton(
               text: Languages.of(context).cart,
               press: () async{

                setState(() {
                   buy();
                });




               },
             ),
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
if(widget.product.type.contains('ملابس') || widget.product.type.contains('احذية') ){
  if(lsize.isNotEmpty && pcl.isNotEmpty){
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyyMMddHms');
    final String formatted = formatter.format(now);
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    final ref = await FirebaseDatabase.instance.reference().child('Users');
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;

    ref.child(uid+"/cart/${formatted}").set({
      'productid':widget.product.id,
      'title':widget.product.title,
      'image':await storage.read(key: 'imm'),
      'number':getnum(context),
      'price':widget.product.price,
      'id':formatted,
      'color':pcl,
      'size':lsize


    });
    cot dat=new cot(widget.product.id);
    addnotif(context,dat);
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
}else {
  if(pcl.isNotEmpty){
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyyMMddHms');
    final String formatted = formatter.format(now);
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    final ref = await FirebaseDatabase.instance.reference().child('Users');
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;

    ref.child(uid+"/cart/${formatted}").set({
      'productid':widget.product.id,
      'title':widget.product.title,
      'image':await storage.read(key: 'imm'),
      'number':getnum(context),
      'price':widget.product.price,
      'id':formatted,
      'color':pcl,
      'size':lsize


    });
    cot data=new cot(widget.product.id);

    addnotif(context,data);

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
    showDialog(context: context,
        builder: (BuildContext context){
          return ErrorDialogBox(
            title: "خطأ",
            descriptions: "اختيار اللون",
            text: "حسناً",
          );
        }
    );
  }

}


/*
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyyMMddHms');
    final String formatted = formatter.format(now);
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    final ref = await FirebaseDatabase.instance.reference().child('Users');
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;

    ref.child(uid+"/cart/${formatted}").set({
      'productid':widget.product.id,
      'title':widget.product.title,
      'image':await storage.read(key: 'imm'),
      'number':numOfItems,
      'price':widget.product.price,
      'id':formatted,
      'color':pcl,
      'size':lsize


    });
*/
    pcl.clear();
    lsize.clear();


  }

}

class Textsize extends StatefulWidget{
  String size;
  Textsize({Key key,  this.size,}) : super(key: key);
  @override
  text createState()=>text();
}
List<String>lsize=[];
class text extends State<Textsize>{
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




  List<String> coloritem=[];
  List dd(){
    return coloritem;
  }
var distinctIds;
List<Color> pp;
List<int>pcl=[];

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
int aa=widget.color;
    coloritem.clear();

    int a=widget.count;
     //  pp=[colorr];

    return InkWell(
        onTap: () {



          setState(() {


            message = "Bye";

            _toggle();
            if(hidtext==true){
              pcl.add(widget.color);
              print(pcl);

            }else{
              pcl.remove(widget.color);

            }




          });
        },

             child: Container(
                margin: EdgeInsets.only(right: 2),
                padding: EdgeInsets.all(getProportionateScreenWidth(3)),
                height: getProportionateScreenWidth(25),
                width: getProportionateScreenWidth(25),
                decoration: BoxDecoration(
                  color:  hidtext ? Colors.white : Colors.transparent,
                  border:
                  Border.all(color: hidtext ? Color(0xFFFF0036) : Colors.black54),
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
