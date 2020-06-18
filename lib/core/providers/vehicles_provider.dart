import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerente_loja/core/models/vehicle.dart';
import 'package:gerente_loja/core/models/vehicle_user.dart';
import 'package:gerente_loja/helpers/const_global.dart';




class VehiclesProvider {


  Future<List<Vehicle>> getVehicles() async {
    bool connectionState = await DataConnectionChecker().hasConnection;

    List<Vehicle> _vehicles;

    if (connectionState) {
      await  Firestore.instance.collection("vehicle").getDocuments().then((querySnap) {
        _vehicles =  querySnap.documents.map((item) {

          return Vehicle(
              icon: item.data['icon'],
              make: item.data['make'],
              model: item.data['model'],
              trim: item.data['trim'],
              year: item.data['year']);
        }).toList();
      });

      return _vehicles;

    } else {
      return List();
    }
  }//

  Future<List<VehicleUser>>  getVehicleByUser()async {

    FirebaseUser uId= await ConstGlobal.getCurrentUser();
    bool connectionState = await DataConnectionChecker().hasConnection;

    List<VehicleUser> _vehicles;

    if (connectionState) {
      await  Firestore.instance.collection("vehicleUser").where("userId",isEqualTo: uId.uid).getDocuments().then((querySnap) {
        _vehicles =  querySnap.documents.map((item) {

          return VehicleUser(

              id:item.data['id'] ,
              icon: item.data['icon'],
              make: item.data['make'],
              model: item.data['model'],
              trim: item.data['trim'],
              year: item.data['year']);


        }).toList();
      });

      return _vehicles;

    } else {
      return List();
    }


  }


  Future<Vehicle>  getVehicleById(String vId)async {

    bool connectionState = await DataConnectionChecker().hasConnection;

    Vehicle  vehicle;

    if (connectionState) {
      await  Firestore.instance.collection("vehicle").document(vId).get().then((item) {
        vehicle =   Vehicle(
          icon: item.data['icon'],
          make: item.data['make'],
          model: item.data['model'],
          trim: item.data['trim'],
          year: item.data['year'],

        );
      });

      return vehicle;

    } else {
      return null;
    }


  }
}
