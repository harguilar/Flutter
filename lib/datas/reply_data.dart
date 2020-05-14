import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Reply{

  String vendorId;
  String vendorName;
  DateTime data;
  bool brandNew;
  double price;


  Reply({@required this.vendorId,@required this.vendorName, @required this.data,@required  this.brandNew, @required  this.price});
 // factory Reply.fromJson(Map<dynamic, dynamic> json) => _replyFromJson(json);

// factory Reply.fromJson(Map<dynamic, dynamic>json)=> _ReplyFromJson(json);
  Map<String,dynamic> toJson() => _ReplyToJson(this);


  Map<String, dynamic> _ReplyToJson(Reply instance) => <String, dynamic> {
    'vendorId' : instance.vendorId,
    'vendorName': instance.vendorName,
    'data': instance.data,
    'brandNew': instance.brandNew,
    'price': instance.price,
  };



  static Reply replyFromJson(Map<dynamic,dynamic> json){
    return Reply(
        vendorId: json['vendorId'],
        vendorName: json['vendorName'],
        data: json['data'] == null ? null : (json['data'] as DateTime),
        brandNew: json['brandNew'] as bool,
        price: json['price'] as double);


  }



  Reply.fromDocument(DocumentSnapshot snapshot){
    vendorId=snapshot.data['vendorId'];
    vendorName=snapshot.data['vendorName'];
    data = snapshot.data['data'].toDate();
    brandNew =snapshot.data['brandNew'];
    price = snapshot.data['price'];
  }


}