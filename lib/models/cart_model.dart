import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:jeilaonlinestore/datas/cart_product.dart';
import 'package:jeilaonlinestore/datas/products_data.dart';
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
    //now notify listersn,
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
  void incProduct(CartProduct cartProduct){

    //Increase The Quantity.
    cartProduct.quantity ++;

    //Update The Database
    Firestore.instance.collection('users').document(user.firebaseUser.uid).collection('cart')
        .document(cartProduct.cid).updateData(cartProduct.toMap());

    //update Our Screen
    notifyListeners();
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