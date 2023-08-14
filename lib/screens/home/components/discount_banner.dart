import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../size_config.dart';
class DiscountBanner extends StatefulWidget {

  @override
  _dis createState() => _dis();
}
class Todo {
  String key;
  String baner;


  Todo(this.baner);

  Todo.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        baner = snapshot.value["baner"];

  toJson() {
    return {
      "baner": baner,

    };
  }
}



class _dis extends State<DiscountBanner> {


 List<Todo> _todoList = [];
String msg='';
  String bn='';
  var DisplayData;
  Future<String> _setupNeeds() async {
    DatabaseReference ref=  await FirebaseDatabase.instance.reference().child('Banner/');
    ref.once().then((DataSnapshot datasnapshot){

        _todoList.add(Todo.fromSnapshot(datasnapshot));
        print(Todo.fromSnapshot(datasnapshot).baner);
        bn=Todo.fromSnapshot(datasnapshot).baner;


      setState(() {

      });
    });



  }
 final Future<String> _calculation = Future<String>.delayed(
   const Duration(seconds: 1),
       () => 'Data Loaded',
 );
  @override
  void initState() {
  _setupNeeds();


    super.initState();
  }
  @override
  Widget build(BuildContext context) {

              return Container(
                height: 100,

                width: double.infinity,
                margin: EdgeInsets.all(getProportionateScreenWidth(15)),
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenWidth(10),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFEF103F),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),

                /*child: Text.rich(

            TextSpan(
              style: TextStyle(color: Colors.white),

              children: [

                TextSpan(text: '${bn}',

                  style: TextStyle(

                      fontSize: getProportionateScreenWidth(18),
                      fontFamily:"beIN",
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),


              ],
            ),

          ),*/



                child:Text.rich(

                  TextSpan(
                    style: TextStyle(color: Colors.white),

                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(1, 20, 140, 0),

                        ),
                      ),
                      TextSpan(text: "${bn}",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontFamily:"beIN",
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),

                    ],
                  ),

                ),

              );




  }
}
