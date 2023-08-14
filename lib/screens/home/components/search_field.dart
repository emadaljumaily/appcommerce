import 'dart:async';

import 'package:appcommerce/provider/products.dart';
import 'package:provider/provider.dart';
import 'package:appcommerce/models/Data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'body.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    Key key,
  }) : super(key: key);
@override
  search createState() => search();
}
class search extends State <SearchField>{
  List<Dataa> datalist=[];
  Dataa _dataa;
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
        () => 'Data Loaded',
  );
  void insertItem(context,Dataa item){
    return Provider.of<Services>(context,listen: false).add(item);
  }

  void removall(context){
    return Provider.of<Services>(context,listen: false).removall();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
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
            hintTextDirection: TextDirection.rtl,
            prefixIcon: Icon(Icons.search)),
      ),
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
        /*Timer(Duration(seconds: 1),(){
          setState(() {
            //
            Body.productwidget(context);
          });
        });*/

      }
    });

  }

}
