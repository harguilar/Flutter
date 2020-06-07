import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jeilaonlinestore/datas/products_data.dart';

class CartProduct {
  String cid;
  String category;
  String pid;
  int quantity;
  String size;
  ProductData productData;

  //Create a Construct For the Product in the Cart.
  //Get the Information From The DB
  CartProduct.fromDoucment(DocumentSnapshot document){
    //Get The Document ID
    cid = document.documentID;
    //Get Category
    category = document.data['category'];
    //Get Product ID
    pid = document.data['pid'];
    //Get Quantity
    quantity = document.data['quantity'];
    //Get Size
    size = document.data['size'];
  }
  //Now we must also to Write the Data Into DB Based on our request.
  //Create a String Dynamic Function to write into the DB
  Map<String, dynamic> toMap(){
    return {
      'category': category,
      'pid': pid,
      'quantity': quantity,
      'size': size,
      //We also going to add product which is going to be a summary of everyting that will
      //show up in our requests.
      'product':productData.productsResumed(),
    };
  }
}