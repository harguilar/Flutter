import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:jeilaonlinestore/datas/cart_product.dart';
import 'package:jeilaonlinestore/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model{

  //Access Card Model from anyWhere by Defining Its Scopped model.
  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);
      //Define Which User is in.
  UserModel user;
  //Create a List of Products.
  List<CartProduct> products = [];
  bool isLoading = false;


  //Create the Constructor with user
  CartModel(this.user) {
    //Load my Items if am Logged in.
    if (user.isLoggedIn())
      _loadCartItems();
  }
  //Add Product to Carts
  void addCartItems(CartProduct cartProduct){
    //Add the Product to Cart List
    products.add(cartProduct);
   //Add The Product to Firebase Based on The User ID.
    Firestore.instance.collection('users').document(user.firebaseUser.uid)
    .collection('cart').add(cartProduct.toMap()).then((doc){
      //Note: When we add a product to cart, it will not have an ID type of the Cart(cid) therefore we create one.
      //Create a Cart ID for the Document based on the info got from Firebase.
       cartProduct.cid = doc.documentID;
    });
    //now notify listerns,
    notifyListeners();
  }
  void removeCartItems(CartProduct cartProduct){
    //Remove The product from Firebase
    Firestore.instance.collection('users').document(user.firebaseUser.uid).collection('cart')
        .document(cartProduct.cid).delete();
    //remove the product from the List
     products.remove(cartProduct);
     //notify listerns
    notifyListeners();
  }
  void decProduct(CartProduct cartProduct){
    //Decrease The Quantify
    cartProduct.quantity --;
    //Update The Database
    Firestore.instance.collection('users').document(user.firebaseUser.uid).collection('cart')
    .document(cartProduct.cid).updateData(cartProduct.toMap());
    //update Our Screen
    notifyListeners();
  }
  //Get The Price of the Product

  double getProductPrice(){
    double price = 0.0;
    //Check all the product in Cart Product.
    for (CartProduct cart in products){
      if( cart.productData !=null )
        price += cart.productData.price * cart.quantity;
    }
    return price;
  }

  //Get The Discount
  double getTax (){
    //Vat.
    return (getProductPrice() * 0.06);
  }
  void updatePrice(){
    //To update the price just need to notify the listeners.
    notifyListeners();
  }
  //Get the Delivery Price.
  double getDelivery(){
    return (getProductPrice() * 0.1);
  }

  double getTotal(){
    double total = 0.0;
    total = getProductPrice() + getTax() + getDelivery();
    return total;
  }

  void incProduct(CartProduct cartProduct){
    //Increase The Quantity.
    cartProduct.quantity ++;
    //Update The Database
    Firestore.instance.collection('users').document(user.firebaseUser.uid).collection('cart')
        .document(cartProduct.cid).updateData(cartProduct.toMap());
    //update Our Screen
    notifyListeners();
  }

  Future<String> finishOrder() async {
    //check if the cart is empty
    if (products.length == 0) return null;

    isLoading = true;
    //notify the listerns
    notifyListeners();
    double productPrice = getProductPrice();
    double deliveryPrice = getDelivery();
    double tax = getTax();
    double total = getTotal();

    //Add Orders to FireBase. and Get the Id of the Document.
    DocumentReference refOrder = await Firestore.instance.collection('orders').add(

      {
        //Add the MAP to firestore.
        'clientID': user.firebaseUser.uid,
        //Convert The product in our Cart  to Map list.
        'products': products.map((cartProduct) => cartProduct.toMap()).toList(),
        'delivery': deliveryPrice,
        'tax': tax,
        'total': total,
        //Status 1 means is processing your order 2 means is done.
        'status': 1
      }
      //Now Lets Safe the Order ID within our User. so that we are aware which order belongs to which user.
    );
      await Firestore.instance.collection('users').document(user.firebaseUser.uid)
        .collection('orders').document(refOrder.documentID).setData(
        {
          'OrderId': refOrder.documentID,
        }
    );

      //Delete our Order once done.
    QuerySnapshot query = await Firestore.instance.collection('users').document(user.firebaseUser.uid)
     .collection('cart').getDocuments();
    for (DocumentSnapshot doc in query.documents){
      //delete the Document
      doc.reference.delete();
    }
    //Clear your Local list
    products.clear();

    isLoading = false;

    notifyListeners();

    //return the Document reference so that the User get notified
    return refOrder.documentID;



  }
  //Get all Information for the Cart.
  void _loadCartItems () async{
    QuerySnapshot query = await Firestore.instance.collection('users').document(user.firebaseUser.uid)
    .collection('cart').getDocuments();
    //Transform Every Single Document From a FireBase into a Cart Product and Return a List will all Products
    products = query.documents.map((doc) => CartProduct.fromDoucment(doc)).toList();
    notifyListeners();
  }
}