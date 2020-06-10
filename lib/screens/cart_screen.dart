import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/models/cart_model.dart';
import 'package:jeilaonlinestore/models/user_model.dart';
import 'package:jeilaonlinestore/tiles/cart_tiles.dart';
import 'package:jeilaonlinestore/widgets/cart_price.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';
class CartScreen extends StatelessWidget {
  int p;
  CartScreen(this.p);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        actions: <Widget>[
          Container (
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model){
                 p = model.products.length;
                //if P is Null return 0
                return Text('${p ?? 0} ${p == 1 || p == 0? "ITEM" : "ITENS"}',
                style: TextStyle(fontSize: 17.0,
                fontWeight: FontWeight.bold,
                ),
                );
              },
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model ){
          //Check if user is Log in and is loading
          if (model.isLoading && UserModel.of(context).isLoggedIn()){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(!UserModel.of(context).isLoggedIn()){
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon (Icons.remove_shopping_cart,
                    size: 80.0, color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 16.0,),
                  Text("Log in to Add Products",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0,),
                  RaisedButton(
                    onPressed:(){
                      //GO to Log In Screen
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginScreen())
                      );
                    } ,
                    child: Text( "Log in",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),

                ],
              ),
            );
          } else if (model.products ==  null || model.products.length == 0){
            return Center(
              child: Text('No Product Within Shopping Cart !',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,),
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products.map(
                          (product){
                            return CartTile(product);
                  }).toList()
                ),
                //Pass an anonymous Function
                CartPrice(()async {
                  //Get the Order ID
                  String orderID = await model.finishOrder();
                  if (orderID != null)
                    print(orderID);
                }),
              ],
            );

          }
        },
      ),
    );
  }
}
