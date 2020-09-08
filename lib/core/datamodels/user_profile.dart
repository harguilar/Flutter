import 'package:flutter/cupertino.dart';

class UserProfile{

  String uid;
  String email;
  String name;
  String phone;
  String address;

  UserProfile( this.uid, this.name, this.email, this.phone,this.address);


  Map<String, dynamic> toJson() => {
    "uid":uid,
    "email": email,
    "name": name,
    "phone": phone,
    "address":address,

  };
}