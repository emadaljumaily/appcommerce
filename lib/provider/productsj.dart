import 'dart:async';
import 'dart:collection';
import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/models/Dataj.dart';
import 'package:appcommerce/models/language_data.dart';
import 'package:appcommerce/screens/details/components/body.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';

class Servicess with ChangeNotifier{




  List<Dataj> llist=[];
  Dataa _dataa;
  int selectedd;
  int selected;
  String select;
  int get totalPrice => llist.length;
  int get indexx =>selected;
  int get indexxx =>selectedd;
  String get index =>select;
  String pItem='';
  UnmodifiableListView<Dataj> get items => UnmodifiableListView(llist);

  void add(Dataj item) {
    llist.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void deleteItem(Dataa item){
    llist.remove(item);
    notifyListeners();

  }
  List<Dataj> get itemm {
    return [...items];
  }
  void removall(){
    llist.clear();
    notifyListeners();

  }
  void searchItem(Dataa item){
    llist.remove(item);
    notifyListeners();

  }

  void selectindex(index){
    selected=index;
   notifyListeners();
  }
  void selectindexx(index){
    selectedd=index;
    notifyListeners();
  }
  void selecte(index){
    select=index;
    notifyListeners();
  }
  String get p_Item{
    return pItem;
  }
void insItem(String item){
    pItem=item;
}




  Future<List<Dataj>> getPostssec(String ff) async {
    Query ref=FirebaseDatabase.instance.reference().child("Product/").child('jomla');
    ref.once().then((DataSnapshot datasnapshot){
      if(datasnapshot.value == null)
      {
        pItem=datasnapshot.value;
      }else{
        removall();
        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys){
          if(values[key]["type"]=="${ff}"){
            Dataj data=new Dataj(
              values[key]['id'],
              values[key]['title'],
              values[key]['description'],
              values[key]['image'],
              values[key]['color'],
              values[key]['pricej'],
              values[key]['size'],
              values[key]['rating'],
              values[key]['isFavourite'],
              values[key]['isPopular'],
              values[key]['type'],


            );
            add(data);

          }else{

          }

        }
      }

    });
    notifyListeners();
  }
  Future<List<Dataj>> getPostssecp(String ff) async {
    Query ref=FirebaseDatabase.instance.reference().child("Product/").child('jomla');
    ref.once().then((DataSnapshot datasnapshot){
      if(datasnapshot.value == null)
      {
        pItem=datasnapshot.value;
      }else{
        removall();
        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys){
          if(values[key]["types"]=="${ff}"){
            Dataj data=new Dataj(
              values[key]['id'],
              values[key]['title'],
              values[key]['description'],
              values[key]['image'],
              values[key]['color'],
              values[key]['pricej'],
              values[key]['size'],
              values[key]['rating'],
              values[key]['isFavourite'],
              values[key]['isPopular'],
              values[key]['type'],


            );
            add(data);

          }else{

          }

        }
      }

    });
    notifyListeners();
  }








}