
import 'package:appcommerce/components/coustom_bottom_nav_barr.dart';
import 'package:appcommerce/screens/chat/chatscreen.dart';
import 'package:appcommerce/screens/favorite/favoritescreen.dart';
import 'package:appcommerce/screens/home/home_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/components/coustom_bottom_nav_bar.dart';
import 'package:appcommerce/enums.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  @override
  _pro createState() => _pro();
}
class _pro extends State<ProfileScreen>{
  int _page = 3;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Scaffold(
    //  appBar: AppBar(title: Text("الملف الشخصي"),),
      body: Body(),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        backgroundColor: Color(0x1AFF0036),
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

          this._page=index;


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
      ),
    );
  }
}
