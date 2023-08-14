import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/provider/productdetails.dart';
import 'package:appcommerce/provider/products.dart';
import 'package:appcommerce/screens/details/components/custom_app_bar.dart';
import 'package:appcommerce/screens/details/components/custom_change_product.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/size_config.dart';
import 'colord.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
class getid{
  String id;
  getid(this.id);
}
class Body extends StatefulWidget{
  final Dataa product;

  Body({Key key,  this.product}) : super(key: key);
  @override
  Sa createState() => Sa();
}
class Sa extends State<Body> {

  List<getid>list=[];
  Future get_id(){
    Query ref=FirebaseDatabase.instance.reference().child("Product/").child('mfrd');
    ref.once().then((DataSnapshot datasnapshot){
      if(datasnapshot.value == null)
      {

      }else{

        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys){
          getid data=new getid(
            values[key]['id'],
          );
         list.add(data);
        }
      }
      setState(() {

      });

    });

  }
  /*Future<List<getid>> get_list_id(context){
    return Provider.of<Services>(context,listen: false).get_id();
  }*/
  void reset(context){
    return Provider.of<Services>(context,listen: false).reseCounter();
  }

  @override
  void initState() {
    get_id();


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final pr = Provider.of<Productdetails>(context).llist;
    return FutureBuilder(
        future: FirebaseDatabase.instance.reference().child("Users/").once(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: [
                CustomAppBar(),
                ProductImages(product: widget.product),
                TopRoundedContainer(
                  color: Colors.white,
                  child: Column(
                    children: [
          Text(pr[0].title,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.red),
          ),
                      Customchangeproduct(list,widget.product),

                      ProductDescription(
                        product: widget.product,
                        pressOnSeeMore: () {},
                      ),
                      TopRoundedContainer(
                        color: Color(0xFFF6F7F9),
                        child: Column(
                          children: [
                            Colords(product: widget.product),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            );
          }
          else {
            return Center(
              child: CircularProgressIndicator(color: Color(0xFFFF0036),),
              //
            );

          }
        }
    );

  }

}
