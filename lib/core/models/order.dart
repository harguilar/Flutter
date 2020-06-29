import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String id;
  double price;
  int status;
  String title;
  int quantity;
  DateTime date;
  double totalPrice;
  String vendorName;
  String buyerName;
  String imgUrl;
  String vehicle;

  Order(
      {this.id, this.price, this.status, this.title, this.quantity,
        this.date, this.totalPrice,this.vendorName,this.buyerName, this.imgUrl,this.vehicle});

  Order.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    price = snapshot.data['price'].toDouble();
    status = snapshot.data['status'];
    title = snapshot.data['title'];
    quantity = snapshot.data['quantity'];
    date = snapshot.data['date'].toDate();
    totalPrice = snapshot.data['totalPrice'].toDouble();
    vendorName = snapshot.data['vendorName'];
    buyerName=snapshot.data['buyerName'];
    imgUrl=snapshot.data['imgUrl'];
    vehicle=snapshot.data['vehicle'];
  }
}