import 'package:flutter/cupertino.dart';

class VehicleModel{
  final String icon;
  final String make;
  final String model;
  final String trim;
  final int year;
  final String vinNumber;

  VehicleModel ({this.icon, this.make, this.model, this.trim, this.year, this.vinNumber});

  VehicleModel.fromMap(Map snapshot, String id) :
      //id = id ?? '',
      icon = snapshot['icon'] ??'',
      make = snapshot['make'] ??'',
      model = snapshot['model'] ?? '',
      trim = snapshot['trim']?? '',
      year = snapshot['year']?? '',
      vinNumber = snapshot['vinNumber'];

  toJson(){
    return {
       'make':make,
       'model':model,
       'trim': trim,
       'year': year,
       'vinNumber':vinNumber,
    };
  }
}