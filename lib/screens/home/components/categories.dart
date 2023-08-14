import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {


  List<String> categories = ["الكل", "ساعات","اجهزة","حقائب","احذية","ملابس"];
  // By default our first item will be selected
  int selectedIndex = 0;
  Future checkFirst(int index ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //bool _seen = (prefs.getBool('seenn') ?? false);
    if(index==0){
      prefs.setString('page',"zero");
    } else if(index ==1){
        prefs.setString('page',"one");

    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(

        height: 50,
        child: ListView.builder(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          checkFirst(index);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

        Container(
        padding: EdgeInsets.only(left: 5.0),
          child:Text(

            categories[index],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
                fontFamily:"beIN",
              color: selectedIndex == index ? Color(0xFFEF103F) : kTextColor,
            //  backgroundColor: selectedIndex == index ? Color(0x34FF0036) : Colors.transparent,
            ),
            textAlign: TextAlign.center,

          ),

        ),
           /* Text(

              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? Color(0xFFEF103F) : kTextLightColor,
              ),
              textAlign: TextAlign.left,

            ),*/
            Container(
              margin: EdgeInsets.only(top: 10.0 / 4), //top padding 5
              height: 2,
              width: 50,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}

/*
class Categories extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "الكل"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "ساعات"},
      {"icon": "assets/icons/Game Icon.svg", "text": "موبايلات"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "هدايا"},
      {"icon": "assets/icons/Discover.svg", "text": "ملابس"},
      {"icon": "assets/icons/Discover.svg", "text": "احذية"},
      {"icon": "assets/icons/Discover.svg", "text": "جنط"},
    ];

    /*return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
          //  icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {},
          ),
        ),
      ),
    );*/
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => CategoryCard(

            text: categories[index]["text"],

            press: () { }),
        ),
      ),
    );
  }
}







class CategoryCard extends StatelessWidget {
 final int selectedIndex = 2;
  const CategoryCard({
    Key? key,
   //required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String?  text;
  final GestureTapCallback press;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
             text!,

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                //color: Color(0xFFEF103F),
                color: selectedIndex == press ? Color(0xFFEF103F) : Colors.black,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0 / 4), //top padding 5
              height: 10,
              width: 30,
              color: selectedIndex == press ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );


  }
}*/
