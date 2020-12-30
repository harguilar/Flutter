import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/tabs/home_tab.dart';
import 'package:jeilaonlinestore/tabs/orders_tab.dart';
import 'package:jeilaonlinestore/tabs/places_tabs.dart';
import 'package:jeilaonlinestore/tabs/products_tab.dart';
import 'package:jeilaonlinestore/widgets/cart_button.dart';
import 'package:jeilaonlinestore/widgets/customer_drawer.dart';



class HomeScreen extends StatelessWidget {

  //we Create This to allow us Navigate Between Pages.
  final _pageController = PageController();
  String data;
  @override
  Widget build(BuildContext context) {

    return PageView(

      controller: _pageController,
      //This will allow us to control the page change through the code instead of dragging.
      physics: NeverScrollableScrollPhysics(),

      children: <Widget>[
        Scaffold(
//
          body: HomeTab(),
          //We create a Drawer to slide us The information.
          drawer: CustomDrawer(_pageController),
          //The Carting Button to Home Page
          floatingActionButton: CartButton(),
        ),
        //Create Another Pages

        Scaffold(
          appBar: AppBar(
            title: Text('Productos'),
            centerTitle: true,
          ),
          //We create a Drawer to slide us The information.
          drawer: CustomDrawer(_pageController),
          //This will Allow to Display All The Products in the Screen
          body:  ProductTab(),
          //The Carting Button to Product Page
          floatingActionButton: CartButton(),
        ),
       // Container(color: Colors.yellow,),
        Scaffold(
          appBar: AppBar(
            title: Text('Minhas Lojas'),
            centerTitle: true,
          ),
          body: PlacesTabs(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meu Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}




