import 'dart:collection';
import 'package:appcommerce/models/offers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

class Provideroffer with ChangeNotifier{
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  List<Offer> list_offer=[];
  List<Offer> list_offerf=[];

  UnmodifiableListView<Offer> get items => UnmodifiableListView(list_offer);
  UnmodifiableListView<Offer> get itemss => UnmodifiableListView(list_offerf);

  void add(Offer item) {
    list_offer.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  List<Offer> get itemm {
    return [...items];
  }

  List<Offer> get itemf {
    return [...itemss];
  }
  void removall(){
    list_offerf.clear();
    notifyListeners();
  }
  List<String> dd=[];
  List<String> ff=[];
  Future<List<Offer>> ofer() async{
    removall();

    final FirebaseUser user = await firebaseAuth.currentUser();
    String uid = user.uid;
    final ref =  await FirebaseDatabase.instance.reference().child("Product").child('mfrd');
    ref.once().then((DataSnapshot datasnapshot){
      if(datasnapshot.value == null)
      {
       // mm=datasnapshot.value;
      }else{

        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
          for(var key in keys){
          if(values[key]['offer']==0){
            dd.add(values[key]['type']);

            ff = dd.toSet().toList();
            Offer _off=new Offer(values[key]['image']);
            add(_off);
           // off.add(_off);
            list_offerf=itemm.toSet().toList();
          }
        }
      }
    });
  }
}