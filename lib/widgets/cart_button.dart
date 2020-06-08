import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/screens/cart_screen.dart';

class CartButton extends StatelessWidget {
  int prod;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white,),
      onPressed:(){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> CartScreen(prod)),
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
