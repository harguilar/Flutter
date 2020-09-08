import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Vehicle {
   String icon;
   String make;
   var model;

  Vehicle.fromDocument(DocumentSnapshot documentSnapshot){

    icon = documentSnapshot.data['icon'];

    make = documentSnapshot.data['make'];

    model = documentSnapshot.data['model'];
  }
}