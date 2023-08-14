import 'package:appcommerce/models/Cartj.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../size_config.dart';
import 'package:appcommerce/screens/jomla/cartjomla/componentcart/cart_cardj.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Bodycart extends StatefulWidget {
  List<Cartj> list;
  String masg;
  Bodycart(this.list,this.masg);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Bodycart> {

  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  String uid;
  Future<String> getUID() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;
    return uid;
  }
  @override
  void initState() {
    // TODO: implement initState
    getUID();
    if (widget.list==0){

    }
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
        future: FirebaseDatabase.instance.reference().child("Product").child('jomla').once(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if(widget.masg !=null){
              return Padding(
                padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: ListView.builder(
                  itemCount: widget.list.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(widget.list[index].productid.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {

                          FirebaseDatabase.instance.reference()
                              .child('Users/${uid}/jomla/${widget.list[index].ke}/').remove();
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
                      child: Carttjomla(cart: widget.list[index]),
                    ),
                  ),
                ),
              );
            }else{
              return Center(
                child:Padding(
                  padding:
                  EdgeInsets.only(top: 60),
                  child: Text('السلة فارغة ',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.red),
                  ),
                ),

              );
            }

          } else {
            return Center(
              child: CircularProgressIndicator(color: Color(0xFFFF0036),),
              //
            );
          }
        }
    );

  }
}
