import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jeilaonlinestore/screens/category_screen.dart';

class ProductData {
  String category;
  String id;
  String title;
  String description;
  double price;
  List images;
  List sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    try {
      id = snapshot.documentID;
      title = snapshot.data['title'];
      description = snapshot.data['description'];
      //Force The Price To Always be a Double.
      price = (snapshot.data['price'] + .0);
      images = snapshot.data['images'];
      sizes = snapshot.data['sizes'];
    }
    catch (e){
      print(e);
    }
  }
}