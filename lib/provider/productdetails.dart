


import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class listprod{
  String id,title,description,rating;
  int price;
  dynamic image = new List<String>();
  dynamic colors = new List<int>();
  dynamic size = new List<String>();
  bool isFavourite, isPopular;
  String type;



  listprod(
      this.id,
      this.title,
      this.description,
      this.image,
      this.colors,
      this.price,
      this.size,
      this.rating,
      this.isFavourite,
      this.isPopular,
      this.type,

      );

}
class Productdetails with ChangeNotifier{
  List<listprod> llist=[];
  String pItem='';
  UnmodifiableListView<listprod> get items => UnmodifiableListView(llist);
  void removall(){
    llist.clear();
    notifyListeners();

  }
  void add(listprod item) {
    llist.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
  String get p_Item{
    return pItem;
  }
  Future<List<listprod>> getproduct(String ff) async{
    removall();
    DatabaseReference ref=FirebaseDatabase.instance.reference().child("Product").child('mfrd');
    ref.once().then((DataSnapshot datasnapshot){
      var keys=datasnapshot.value.keys;
      var values=datasnapshot.value;
      if(datasnapshot.value == null)
      {
        pItem=datasnapshot.value;
      }else{

        for(var key in keys) {
          if(values[key]["id"]=="${ff}"){
            listprod datae = new listprod(
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
            add( datae) ;
          }else{

          }
        }
      }



    });


    notifyListeners();
  }


}