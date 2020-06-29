import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String imageUrl;
  String email;
  String phone;
  String address;
  Map<String , dynamic> rooms={};

  User({this.id, this.name, this.imageUrl,this.email,this.phone,this.address,this.rooms});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["userVehiclId"],
        imageUrl: json["date"],
      );

  User.fromDocument(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.documentID;
    name = documentSnapshot.data['name'];
    imageUrl = documentSnapshot.data['imageUrl'];
    email=documentSnapshot.data['email'];
    phone= documentSnapshot.data["phone"];
    address = documentSnapshot.data[address];
    rooms=documentSnapshot.data['rooms'];
  }
  Map<String, dynamic> toJson() =>
      {'id': id, "name": name, "imageUrl": imageUrl,"email":email,"phone":phone,"address":address,'rooms':rooms};
}
