import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class UserModel {
  String uid;
  String email;
  String name;
  String phoneNo;
  String address;
  bool hasCar;

  UserModel(
      {@required this.uid,
        @required this.name,
        @required this.email,
        @required this.phoneNo,
        @required this.address,
        @required this.hasCar
      }
      );

  Map<String, dynamic> toJson() => {
    "userID": uid,
    "email": email,
    "name": name,
    "phone": phoneNo,
    "address": address,
    "hasCar": hasCar
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uid: json["userId"],
      name: json["name"],
      email: json["email"],
      phoneNo: json["phone"],
      address: json["address"],
      hasCar: json["hasCar"]
  );

  UserModel.fromDocument(DocumentSnapshot documentSnapshot) {
    uid = documentSnapshot.documentID;
    name = documentSnapshot.data['name'];
    email = documentSnapshot.data['email'];
    phoneNo = documentSnapshot.data['phone'];
    address = documentSnapshot.data['address'];
    hasCar=documentSnapshot.data["hasCar"];
  }
}