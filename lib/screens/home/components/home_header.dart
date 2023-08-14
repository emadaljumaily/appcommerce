import 'package:appcommerce/DialogLogin.dart';
import 'package:appcommerce/notfi/det_screen.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/screens/cart/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';
import 'package:appcommerce/changescreen.dart';
import 'package:firebase_database/firebase_database.dart';
class Homeheader extends StatefulWidget {
  final FirebaseAuth auth;
  Homeheader({
    Key key,this.auth
  }) : super(key: key);
  @override
 _hom createState()=> _hom();
}
class cot{
  String name;
  cot(this.name);
}
class notf{
  String name;
  notf(this.name);
}
class _hom extends State<Homeheader>{
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
final TextEditingController _textFieldController = TextEditingController();
bool _validate = false;
String msg='';
  List<cot> list=[];
  String uid;
int count=0;
  void getDataa() async{
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;
    final ref =  FirebaseDatabase.instance.reference().child("Users/$uid/cart");
    ref.once().then((DataSnapshot datasnapshot){
      list.clear();
      var keys=datasnapshot.value.keys;
      var values=datasnapshot.value;
      for(var key in keys){
        cot dat=new cot(
            values[key]['productid'],

        );

        //print(datasnapshot.value);
        //sum += values[key]['price'].;
        //final sum = list.sum;
        list.add(dat);
        count=list.length;
        if(list.length >0){
          print('dfdf${keys}');
        }else{
          print('dfdfgggggggggggggggggggg');
        }

        setState(() {


        });
        //list.length;
      }



    });

  }
  List<notf>lst=[];
  int cout=0;
  void notfi() async{
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;
    final ref =  FirebaseDatabase.instance.reference().child("Users/notif/${uid}");
    ref.once().then((DataSnapshot datasnapshot){
      lst.clear();
      var keys=datasnapshot.value.keys;
      var values=datasnapshot.value;
      for(var key in keys){
        notf da=new notf(
          values[key]['title'],

        );

        //print(datasnapshot.value);
        //sum += values[key]['price'].;
        //final sum = list.sum;
        lst.add(da);
        if(lst.length >0){
          cout=1;
        }


        print('dfdf${lst.length}');

        //list.length;
        setState(() {


        });
      }



    });

  }

@override
  void initState() {
      getDataa();
      notfi();
       super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Lock.svg",
            press: ()=>Navigator.push(context, new MaterialPageRoute(
              builder: (context) => new ChangeScreen())
          ),
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () => Navigator.pushNamed(context, CartScreen.routeName),
            numOfitem: count,
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: cout,
            press: ()=>Navigator.push(context, new MaterialPageRoute(
                builder: (context) => new DetScreen())
            ),
          ),
        ],
      ),
    );
  }
Future<String> _resetDialogBox() {

  return showDialog<String>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: "ادخل كلمة المرور",
        auth: widget.auth,
      );
    },
  );
}

}
