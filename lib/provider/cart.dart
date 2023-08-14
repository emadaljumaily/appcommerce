import 'dart:collection';
import 'package:appcommerce/models/Cart.dart';
import 'package:appcommerce/screens/cart/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:translator/translator.dart';

class Carts with ChangeNotifier {


  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  List<Cart> list = [];
  String pItem='';
  int sum=0;
  int total=0;
  UnmodifiableListView<Cart> get items => UnmodifiableListView(list);

  void add(Cart item) {
    list.add(item);
    notifyListeners();
  }
  void remove(){
    list.clear();
    notifyListeners();

  }
  void removeindex(index){
    list.removeAt(index);
    notifyListeners();

  }
  List<Cart> get item {
    return [...items];
  }
  String get p_Item{
    return pItem;
  }
  int get totl{
    return total;
  }
  int get totalsum{
    return sum;
  }
  String it='';
String get citem{
    return it;
}
  List<int>yy=[];
void removecartprice(){
  yy.clear();
  notifyListeners();
}
int inside=0;
   void removecartpriceindexx(int index){
    this.sum=index;

   }


  Future<List<Cart>> getCart() async {
     removecartprice();
     sum=0;
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;
    final ref =  FirebaseDatabase.instance.reference().child("Users/$uid/cart");

    ref.once().then((DataSnapshot datasnapshot){
      if(datasnapshot.value == null)
      {
        it=datasnapshot.value;

      }else{
        remove();
        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys){
          Cart dat=new Cart(
            values[key]['productid'],
            values[key]['title'],
            values[key]['price'],
            values[key]['number'],
            values[key]["image"],
            values[key]['id'],
            values[key]['color'],
            values[key]['size'],
          );


          add(dat);
        }
        int a=0;

        for (var i = 0; i < list.length; i++) {
          a =list[i].price * list[i].number;
          yy.add(a);

          print("gggggg : ${a}");

        }
       // int uu=0;
        for (var i = 0; i < yy.length; i++) {
          sum += yy[i];
        }

        total = list.where((c) => c.number == c.number).toList().length;
        print("oooo : ${sum}");
      }



    });





    notifyListeners();
  }

  String phone;
  String address;

  List<Inf> listinfo=[];

  UnmodifiableListView<Inf> get iteminfo => UnmodifiableListView(listinfo);
  List<Inf> get iteminf {
    return [...iteminfo];
  }
  /*String get p_Item{
    return pItem;
  }*/
  void getinfo()async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;
    final ref = FirebaseDatabase.instance.reference().child("Users/$uid/");
    listinfo.clear();
    ref.once().then((DataSnapshot datasnapshot) {
      if (datasnapshot.value == null) {
        // print('no data');
        // msg = datasnapshot.value;
      } else {

        var keys = datasnapshot.value.keys;
        var values = datasnapshot.value;
        for (var key in keys) {
          Inf inf = new Inf(
            values[key]["phone"],
            values[key]['Address'],
          );
          listinfo.add(inf);

        }
        for(int i=0;i<listinfo.length;i++){
          phone=listinfo[i].phon.toString();
          address=listinfo[i].address;
        }

      }

    });
    notifyListeners();
  }




}