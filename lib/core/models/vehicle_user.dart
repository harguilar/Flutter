import 'package:flutter/cupertino.dart';

class VehicleUser{

  final String id;
  final String icon;
  final String make;
  final String model;
  final String trim;
  final int year;
  final String vinNumber;


  VehicleUser({@required this.id,@required this.icon,
    @required this.make,@required this.model,@required this.trim,@required this.year,@required this.vinNumber} );

  factory VehicleUser.fromJson(Map<String, dynamic> json){

    return VehicleUser
      (
        id: json["id"] as String,
        icon: json["icon"] as String,
        make: json[ "make"] as String,
        model: json["model"] as String,
        trim: json[ "trim"] as String,
        year: json["year"] as int,
        vinNumber: json["vinNumber"]
      );
  }

}