

import 'package:appcommerce/screens/chat/chatscreen.dart';
import 'package:appcommerce/screens/favorite/favoritescreen.dart';
import 'package:appcommerce/screens/home/home_screen.dart';
import 'package:appcommerce/screens/profile/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../enums.dart';
import '../size_config.dart';

class CustomBottomNavBarr extends StatefulWidget {
  final MenuState selectedMenu;
  CustomBottomNavBarr({
    Key key,
   this.selectedMenu,
  }) : super(key: key);

  @override
  _bottom createState() => _bottom();
}
class _bottom extends State<CustomBottomNavBarr>{

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: _page,
      backgroundColor: Colors.blueAccent,
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
    );
  }
}
