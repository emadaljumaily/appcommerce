import 'package:appcommerce/components/cardd.dart';
import 'package:appcommerce/constants.dart';
import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/models/constants.dart';
import 'package:appcommerce/provider/products.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
class PopularProducts extends StatefulWidget {


  @override
  _NeedsState createState() => _NeedsState();
}

class _NeedsState extends State<PopularProducts> {
  List<String> categories = ["الكل", "ساعات","اجهزة","حقائب","احذية","ملابس"];
  int selectedIndex = 0;
  List<Dataa> datalist=[];
  Dataa _dataa;
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
        () => 'Data Loaded',
  );

  @override
  void initState() {
    super.initState();

    DatabaseReference ref=FirebaseDatabase.instance.reference().child("Product/");

    ref.once().then((DataSnapshot datasnapshot){

      datalist.clear();
      var keys=datasnapshot.value.keys;
      var values=datasnapshot.value;
      for(var key in keys){
          Dataa data=new Dataa(
            values[key]['id'],
            values[key]['title'],
            values[key]['description'],
            values[key]['image'],
            values[key]['Color'],
            values[key]['price'],
            values[key]['size'],
            values[key]['rating'],
            values[key]['isFavourite'],
            values[key]['isPopular'],
            values[key]['type'],

          );
          datalist.add(data);


      }

      setState(() {
        //
      });
    });

  }

  double height;

  Future<String> getUID() async {


  }
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    /*Consumer<Services>(
        builder: (context, cart, child) {

        });*/
    return FutureBuilder(
        future:_calculation,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [

                Padding(


                  padding:
                  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
                  /* child: Text("المنتجات",

            textAlign: TextAlign.right,
            style: TextStyle(
             // color: Colors.pink.shade900,
              fontFamily: 'beIN',
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),
          ),*/
                ),

                SizedBox(height: getProportionateScreenWidth(30)),
                Container( height: MediaQuery.of(context).size.height,
                  //  width: 400,

                  padding: EdgeInsets.only(right: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(

                          padding: const EdgeInsets.symmetric(horizontal: 10.0),

                          child: GridView.builder(
                              itemCount: datalist.length,
                              primary: false,

                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                                crossAxisCount: 2,
                                mainAxisSpacing: 15.0,
                                crossAxisSpacing: kDefaultPaddin,
                                childAspectRatio: 0.75,
                              ),

                              itemBuilder: (context, index) =>
                                  Cardd(
                                product: datalist[index],

                              )

                          ),
                        ),
                      ),

                    ],
                  ),

                ),





              ],
            );
          }
          else {
            return CircularProgressIndicator();
          }
        }
    );



  }




  Widget aa(BuildContext context){
    return FutureBuilder(
        future:_calculation,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(

              padding: const EdgeInsets.symmetric(horizontal: 10.0),

              child: GridView.builder(
                  itemCount: datalist.length,
                  primary: false,

                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                    crossAxisCount: 2,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 0.75,
                  ),

                  itemBuilder: (context, index) => Cardd(
                    product: datalist[index],

                  )
              ),
            );
          }
          else {
            return CircularProgressIndicator();
          }
        }
    );

  }

}
