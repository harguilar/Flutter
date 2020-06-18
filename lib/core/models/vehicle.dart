import 'package:flutter/cupertino.dart';

class Vehicle{
  final String icon;
  final String make;
  final String model;
  final String trim;
  final int year;
  final String vinNumber;



  Vehicle({@required this.icon,
    @required this.make,@required this.model,@required this.trim,@required this.year,@required this.vinNumber} );

  factory Vehicle.fromJson(Map<String, dynamic> json){

    return Vehicle(
        icon: json["icon"] as String,
        make: json[ "make"] as String,
        model: json["model"] as String,
        trim: json[ "trim"] as String,
        year: json["year"] as int,
        vinNumber: json["vinNumber"] as String
    );
  }

}