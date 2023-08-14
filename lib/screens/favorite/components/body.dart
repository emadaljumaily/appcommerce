
import 'package:appcommerce/screens/favorite/favoritescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Body extends StatefulWidget {
  List<Cartfav> list;
  String msg;
  Body(this.list,this.msg);




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

  void aa(){
    for(int i=0;i<widget.list.length;i++){
      print('eeee ${widget.list[i].id}');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getUID();

    if (widget.list==0){

    }
    aa();

    super.initState();

  }
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
        () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
   return FutureBuilder(
        future: FirebaseDatabase.instance.reference().child("Users/").once(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if(widget.msg==null){
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
                  itemCount: widget.list.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(widget.list[index].id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction){

                        delDat(widget.list[index].id);
                        print('p: ${widget.list[index].id}');
                          setState((){
                            widget.list.removeAt(index);
                        });

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
                        width: 380,
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

                            CartCard(cart: widget.list[index]),
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
  void delDat(String aa) async {

    final FirebaseUser user = await firebaseAuth.currentUser();
    final uid = user.uid;
    final ref = await FirebaseDatabase.instance.reference().child('Users');
    ref.child(uid).child('favorite').child(aa).remove();
    final reff =await FirebaseDatabase.instance.reference().child('Product');
    reff.child(aa).child('userfav').child(uid).remove();
    //print('uid: $uid \n p: $aa');
  }
}
