import 'dart:async';
import 'package:gerente_loja/core/models/vehicle.dart';
import 'package:gerente_loja/core/models/vehicle_user.dart';
import 'package:gerente_loja/repository/repository.dart';
import 'package:flutter/cupertino.dart';


class VehicleController extends ChangeNotifier {


  Repository _provider = Repository();
  List<VehicleUser> userVehiclesList = List();
  Vehicle vehicle;


  StreamController<List<VehicleUser>> _controller = StreamController<List<VehicleUser>>.broadcast();
  Stream<List<VehicleUser>> get outVehicles => _controller.stream;

  StreamController<Vehicle> _controllerVehicle = StreamController<Vehicle>.broadcast();
  Stream<Vehicle> get outVehiclesById => _controllerVehicle.stream;



  Future<void> getVehicles() {

    return _provider.getVehicleByUser().then(
            (dados) {
          if(dados != null) userVehiclesList = dados;
          notifyListeners();
          return userVehiclesList;

        }
    );
  }

  Future<void> getVehicleById(String vId) {

    return _provider.getVehicleById(vId).then(
            (dados) {
          if(dados != null) vehicle = dados;
          notifyListeners();
          return vehicle;
        }
    );
  }




  @override
  void dispose() {
    // _controller.close();
    //super.dispose();
  }
}