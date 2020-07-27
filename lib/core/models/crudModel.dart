import 'dart:async';
import 'package:flutter/material.dart';
import '../../locator.dart';
import 'vehicleModel.dart';
import 'package:gerente_loja/core/services/api.dart';
import 'package:gerente_loja/core/models/vehicleModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CRUDModel extends ChangeNotifier {
  //Create a Local object
  Api _api = locator<Api>();

  List<VehicleModel> vehicles;

    Future<List<VehicleModel>>fetchVehicles() async{
      var result = await _api.getDataColletions();
      vehicles = result.documents.map((doc)=>VehicleModel.fromMap(doc.data,doc.documentID));
      return vehicles;
    }

    Stream<QuerySnapshot> fetchProductAsStream(){
    return _api.streamDataCollection();
    }
    Future<VehicleModel>getVehicleById(String id) async{
      var doc = await _api.getDocumentById(id);
      return VehicleModel.fromMap(doc.data, doc.documentID);
    }
    Future removeVehicle(String id) async {
      await _api.removeDocumentById(id);
      return ;
    }
    Future updateDocument (VehicleModel data,String id) async{
      await _api.updateDocument(data.toJson(), id);
      return ;
    }
    Future addDocument (VehicleModel data) async {
      await _api.addDocument(data.toJson());
      return;
    }
}



