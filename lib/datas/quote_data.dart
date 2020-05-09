import 'package:cloud_firestore/cloud_firestore.dart';


class QuoteData{

  String id;
  String buyer;
  String data;
  String partName;
  String vehicle;
  int status;
  List images;
  List replies;

  QuoteData(){}

  QuoteData.fromDocument(DocumentSnapshot documentSnapshot){
    id=documentSnapshot.documentID;
    data= documentSnapshot.data['data'];
    partName= documentSnapshot.data['partName'];
    status= documentSnapshot.data['status'];
    images == documentSnapshot.data['images'];
    replies == documentSnapshot.data['replies'];
  }


}