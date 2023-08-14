import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:translator/translator.dart';

class Categors with ChangeNotifier{


  String lang="";
  String selectlang="";
  void selectlanguage(String code){
    selectlang=code;
    notifyListeners();
  }
  String langg(){
    return lang;
  }
  void changelang(String lang){
    lang=lang;
    notifyListeners();
}

  int click=0;
  void clicked(){
    click=1;
    notifyListeners();
  }

  void restclick(){
    click=0;
    notifyListeners();
  }



  int numOfItems=1;
  void addnum(){
    numOfItems++;
    notifyListeners();
  }
  void minnum(){
    numOfItems --;
    notifyListeners();
  }
  void num(){
    numOfItems=1;
    notifyListeners();
  }


  int numOfItemsj=1;
  void addnumj(){
    numOfItemsj++;
    notifyListeners();
  }
  void minnumj(){
    numOfItemsj --;
    notifyListeners();
  }
  void numj(){
    numOfItemsj=1;
    notifyListeners();
  }


 bool wdg=false;
  void checkw(){
    wdg=true;;
    notifyListeners();
  }
  void checkb(){
    wdg=false;
    notifyListeners();
  }


  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;

  List<String>caty=[];
  List<String>catysec=[];
  List<Categor> listc=[];
  List<Categorsec> listsec=[];


  UnmodifiableListView<String> get items => UnmodifiableListView(caty);
  UnmodifiableListView<String> get itemsec => UnmodifiableListView(catysec);

  void add(Categor item) {
    listc.add(item);
    notifyListeners();
  }
  void addsec(Categorsec item) {
    listsec.add(item);
    notifyListeners();
  }
  void removall(){
    listc.clear();
    notifyListeners();
  }
  void removallsec(){
    listsec.clear();
    notifyListeners();
  }
  void removalll(){
    caty.clear();
    notifyListeners();
  }
  void removalllsec(){
    catysec.clear();
    notifyListeners();
  }
  List<String> get item {
    return [...items];
  }
  List<String> get itemse {
    return [...itemsec];
  }

  void cat() async{

    final ref =  FirebaseDatabase.instance.reference().child("Categor");
    ref.once().then((DataSnapshot datasnapshot){
      if(datasnapshot.value == null)
      {
        // print('no data');

      }else{
       removall();
       removalll();
       var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys) {
          Categor da = new Categor(
            values[key]['title'],

          );
          listc.add(da);


        }
        for(int i=0;i<listc.length;i++){
          print('hee ${listc[i].name}');
          caty.add(listc[i].name);
        }
        caty.sort((a, b) => a.toString().compareTo(b.toString()));
        int index = caty.indexOf('الكل');
        caty.remove(index);
        caty.insert(0, 'الكل');
      }


    });
notifyListeners();
  }
  void catsecond(String ff) async{

    final ref =  FirebaseDatabase.instance.reference().child("Categors").child(ff);
    ref.once().then((DataSnapshot datasnapshot){
      if(datasnapshot.value == null)
      {
        print('no data');

      }else{
        listsec.clear();
        catysec.clear();
        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys) {
        //  if(values[key]["type"]=="${ff}"){
            Categorsec da = new Categorsec(
              values[key]['title'],

            );
            listsec.add(da);

         // }


        }
        //print('catc');
        for(int i=0;i<listsec.length;i++){
          print('hed ${listsec[i].name}');
          catysec.add(listsec[i].name);
        }
        print('catc');
        catysec.sort((a, b) => a.toString().compareTo(b.toString()));
        int index = catysec.indexOf('الكل');
        catysec.remove(index);
        catysec.insert(0, 'الكل');
      }


    });
    notifyListeners();
  }
  int count=0;
  List<cot> list=[];
  UnmodifiableListView<cot> get notif => UnmodifiableListView(list);
  void removenotif(){
   list.clear();
   notifyListeners();
  }
  void removenotifitem(index){
    list.removeAt(index);
    notifyListeners();
  }
  void addnotif(cot item) {
    list.add(item);
    notifyListeners();
  }
  List<cot> get lis_notif {
    return [...notif];
  }


  Future notifCart() async{
    final FirebaseUser user = await firebaseAuth.currentUser();
    String uid = user.uid;
    final ref =  await FirebaseDatabase.instance.reference().child("Users/$uid/cart");
    ref.once().then((DataSnapshot datasnapshot){
      if(datasnapshot.value == null)
      {
        //  print('no data');

      }else{
         removenotif();
        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys){
          cot dat=new cot(
            values[key]['productid'],
          );
          addnotif(dat);
          count=lis_notif.length;


        }
      }


    });

  }
}
class Categor{
  dynamic name = new List<String>();
  Categor(this.name);
}
class Categorsec{
  dynamic name = new List<String>();
  Categorsec(this.name);
}



class cot{
  String name;
  cot(this.name);
}