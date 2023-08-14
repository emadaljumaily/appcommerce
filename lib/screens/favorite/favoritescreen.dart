
import 'package:appcommerce/screens/chat/chatscreen.dart';
import 'package:appcommerce/screens/home/home_screen.dart';
import 'package:appcommerce/screens/profile/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';

class Cartfav{
  String id,title;
  int price;
  String image;
  Cartfav({ this.id,
    this.title,
    this.image,
    this.price,});
dynamic tojson()=>{
  'id':id,
  'title': title,
  'image': image,
  'price': price,
};
  factory Cartfav.fromJson(Map<dynamic, dynamic> json) {
    return Cartfav(
      id:json['id'],
      title: json['title'],
      image: json['image'],
      price: json['price'],

    );
  }
  }
class Favscreen extends StatefulWidget {
  static String routeName = "/favourite";
@override
  _fvo createState() => _fvo();
}
  class _fvo extends State<Favscreen>{
  String msg='';
  List<Cartfav> listf=[];
  Cartfav cartfav;
  int _page = 1;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  Future<Cartfav> geta() async{
    listf.clear();
    final FirebaseUser user = await firebaseAuth.currentUser();
     String uid = user.uid;
    final ref = await FirebaseDatabase.instance.reference().child("Users/");
    ref.child(uid).child("favorite/").once().then((DataSnapshot datasnapshot){

      Map<dynamic, dynamic> values = datasnapshot.value;
      if(datasnapshot.value == null)
      {
        // print('no data');
        msg=datasnapshot.value;

      }else{
        values.forEach((key, values) {
          listf.add(Cartfav.fromJson(values));
        });
      }

   // listf.add(Cartfav.fromJson(datasnapshot.value));
     /* if(datasnapshot.value == null)
      {
        // print('no data');
        msg=datasnapshot.value;

      }else{

        var keys=datasnapshot.value.keys;
        var values=datasnapshot.value;
        for(var key in keys){
          Cartfav dat=new Cartfav(
            values[key]['id'],
            values[key]['title'],
            values[key]['image'],
            values[key]['color'],
            values[key]['price'],

          );

          listf.add(dat);
        }
      }*/


      setState(() {

      });

    });

  }
  @override
  void initState() {
   geta();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Scaffold(
     // appBar: buildAppBar(context),
      body: Body(listf,msg),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        backgroundColor: Color(0x1AFF0036),
        color: Colors.white,
        items: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
              color: _page==0
                  ? kPrimaryColor
                  : inActiveIconColor,
            ),
            // onPressed: () => Navigator.pushNamed(context, HomeScreen.routeName),
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/Heart Icon.svg",
              color: _page==1
                  ? kPrimaryColor
                  : inActiveIconColor,
            ),
            //onPressed: ()  =>Navigator.pushNamed(context, Favscreen.routeName),
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg",
              color: _page==2
                  ? kPrimaryColor
                  : inActiveIconColor,
            ),
            // onPressed: () =>Navigator.pushNamed(context, Chatscreen.routeName),
          ),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              color: _page==3
                  ? kPrimaryColor
                  : inActiveIconColor,
            ),
            //onPressed: () =>Navigator.pushNamed(context, ProfileScreen.routeName),
          ),
        ],
        onTap: (index) {
          setState(() {
            this._page=index;

          });
          if(_page==0){
            Navigator.pushNamed(context, HomeScreen.routeName);

          } if(_page==1){
            Navigator.pushNamed(context, Favscreen.routeName);
          } if(_page==2){
            Navigator.pushNamed(context, Chatscreen.routeName);
          } if(_page==3){
            Navigator.pushNamed(context, ProfileScreen.routeName);
          }

          //
          //Handle button tap
        },
      )
    );
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "المفظلة",
            style: TextStyle(color: Colors.black,fontFamily:"beIN"),
          ),

        ],
      ),
    );
  }
}