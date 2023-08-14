
import 'package:appcommerce/models/Data.dart';
import 'package:appcommerce/screens/offers/oferscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Body extends StatefulWidget {
  String type;
  Body({this.type});




  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  String uid;
  Future<String> getUID() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;
    return uid;
  }
  String msg='';
  List<Dataa> datalist=[];
  Dataa _dataa;
  int _page = 1;
  Future geta() async {

    Query ref = await FirebaseDatabase.instance.reference().child("Product/")
        .child('mfrd').orderByChild("type")
        .equalTo(widget.type);
    ref.once().then((DataSnapshot datasnapshot){
      if(datasnapshot.value == null)
      {
        msg=datasnapshot.value;
        print(msg);

      }else{
        datalist.clear();
        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys){
      if(values[key]['offer']==0){
        _dataa=new Dataa(
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
        datalist.add(_dataa);
      }else{

      }

        }
      }
setState(() {

});
    });




  }

  @override
  void initState() {
    // TODO: implement initState
    geta();

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
   return FutureBuilder(
        future:FirebaseDatabase.instance.reference().child("Product/").once(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if(msg==null){
              return Center(
                child:Padding(
                  padding:
                  EdgeInsets.only(top: 60),
                  child: Text('لاتوجد منتجات مفضلة',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.red),
                  ),
                ),

              );
            }else{
              return Padding(
                padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: ListView.builder(
                  itemCount: datalist.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(datalist[index].id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction){


                      },
                      background: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Spacer(),
                            SvgPicture.asset("assets/icons/Trash.svg"),
                          ],
                        ),
                      ),
                      child: Container(
                        width: getProportionateScreenWidth(380),
                        //padding: EdgeInsets.only(left: 50.0),
                        margin:  EdgeInsets.only(left: 14.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),

            child:Row(
              children: [

                CartCar(cart:datalist[index]),
              ],
            ),


                      ),
                     // child: CartCard(cart: widget.list[index]),
                    ),
                  ),
                ),
              );
            }

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
