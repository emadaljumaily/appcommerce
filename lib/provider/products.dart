import 'dart:async';
import 'dart:collection';
import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/models/language_data.dart';
import 'package:appcommerce/screens/details/components/body.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';

class Services with ChangeNotifier{

  //------------Languages-------//

  String lang='';

  void changelang(String value){
    lang=value;
    notifyListeners();
  }
  String get langval{
    return lang;
  }



  ///-------------------////

  var _count = 1;
  bool change=false;


  void incrementCounter() {
    _count += 1;
    notifyListeners();
  }
  void incrementCountermin() {
    _count -= 1;
    notifyListeners();
  }
  void reseCounter() {
    _count = 1;
    notifyListeners();
  }
  int get getCounter {
    return _count;
  }





  List<Dataa> llist=[];
  Dataa _dataa;
  int selectedd;
  int selected;
  String select;
  int get totalPrice => llist.length;
  int get indexx =>selected;
  int get indexxx =>selectedd;
  String get index =>select;
  String pItem='';
  UnmodifiableListView<Dataa> get items => UnmodifiableListView(llist);

  void add(Dataa item) {
    llist.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void deleteItem(Dataa item){
    llist.remove(item);
    notifyListeners();

  }
  List<Dataa> get itemm {
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
Future<List<Dataa>> getPosts() async {
    Query ref=FirebaseDatabase.instance.reference().child("Product/").child('mfrd');
    ref.once().then((DataSnapshot datasnapshot){
      if(datasnapshot.value == null)
      {
        pItem=datasnapshot.value;
      }else{
         removall();
         var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys){
          Dataa data=new Dataa(
            values[key]['id'],
            values[key]['title'],
            values[key]['description'],
            values[key]['image'],
            values[key]['color'],
            values[key]['price'],
            values[key]['size'],
            values[key]['rating'],
            values[key]['isFavourite'],
            values[key]['isPopular'],
            values[key]['type'],

          );
          add(data);
        }
      }

    });
    notifyListeners();
  }
  Future<List<Dataa>> getPostss(String ff) async {
    Query ref=FirebaseDatabase.instance.reference().child("Product/").child('mfrd');
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
            Dataa data=new Dataa(
              values[key]['id'],
              values[key]['title'],
              values[key]['description'],
              values[key]['image'],
              values[key]['color'],
              values[key]['price'],
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


  Future<List<Dataa>> getPostssec(String ff) async {
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
            Dataa data=new Dataa(
              values[key]['id'],
              values[key]['title'],
              values[key]['description'],
              values[key]['image'],
              values[key]['color'],
              values[key]['price'],
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
  Future<List<Dataa>> getPostssecp(String ff) async {
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
            Dataa data=new Dataa(
              values[key]['id'],
              values[key]['title'],
              values[key]['description'],
              values[key]['image'],
              values[key]['color'],
              values[key]['price'],
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