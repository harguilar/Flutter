//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jeilaonlinestore/datas/cart_product.dart';
import 'package:jeilaonlinestore/datas/products_data.dart';
import 'package:jeilaonlinestore/models/cart_model.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;
  //Our Constructor is Getting a CartProduct
  CartTile(this.cartProduct);
  @override
  Widget build(BuildContext context) {

    Widget _buildContent(){
      //Please Update the Price by notifying the listeners.
      CartModel.of(context).updatePrice();
      return Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            width: 120.0,
            child: Image.network(
              //Get the Image From Cart product
              cartProduct.productData.images[0],
              //Cover All the Available Space.
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            //Put a Container To Provide Space.
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cartProduct.productData.title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                  ),
                  Text(
                    'Tamanho: ${cartProduct.size}',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text('AKZ ${cartProduct.productData.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                        //if you put Null in OnPress of a Button the Button will be Disabled.
                        onPressed: cartProduct.quantity > 1? (){
                          //Drecrease Product
                          CartModel.of(context).decProduct(cartProduct);
                        }: null,
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Theme.of(context).primaryColor,
                        onPressed:(){
                          //Increase Product
                          CartModel.of(context).incProduct(cartProduct);
                        },
                      ),
                      FlatButton(
                        child: Text('Remover'),
                        textColor: Colors.grey[500],
                        onPressed: (){
                          //Call The Cart Model Function to Remove Product
                          CartModel.of(context).removeCartItems(cartProduct);
                        },
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),

        ],
      );
    }

    //This Card contains the Info About The Product
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      //Check if Cart Has Products
      child: cartProduct.productData == null ?
          //Search The Firebase to Find the Products
          FutureBuilder<DocumentSnapshot>(
            future: Firestore.instance.collection('products').document(cartProduct.category)
            .collection('items').document(cartProduct.pid).get(),
            //SnapShot is the info we got from the DB
            builder: (context, snapshot){
              if (snapshot.hasData){
                //Convert The Doc. From FireBase Into ProductData
                cartProduct.productData = ProductData.fromDocument(snapshot.data);
               return _buildContent();
              } else {
                return Container(
                  height:  70.0,
                  child: CircularProgressIndicator(),
                  alignment:  Alignment.center,
                );

              }
            },
          ):
          //Cart Product has Data we call. Show This Data with Build Content
      _buildContent(),
    );
  }
}
