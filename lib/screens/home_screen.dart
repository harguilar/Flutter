import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/tabs/home_tab.dart';
import 'package:jeilaonlinestore/widgets/customer_drawer.dart';

class HomeScreen extends StatelessWidget {
  //we Create This to allow us navigative Between Pages.
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      //This will allow us to control the page change through the code instead of dragging.
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body:  HomeTab(),
          //We create a Drawer to slide us The information.
          drawer: CustomDrawer(_pageController),
        ),
        //Create Another Pages
        Container(color: Colors.red,),
        Container(color: Colors.yellow,),
        Container(color: Colors.green,),
      ],
    );
  }
}
