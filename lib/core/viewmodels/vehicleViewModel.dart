import 'package:gerente_loja/core/datamodels/vehicle.dart';
import 'package:gerente_loja/core/services/api.dart';
import 'package:gerente_loja/core/services/sellectedVehicleDetails.dart';
import 'package:gerente_loja/locator.dart';
import 'dart:core';
import 'package:stacked/stacked.dart';

class VehicleViewModel extends BaseViewModel{

  String _make;
  var _model;
  String _selectedCar;

  SellectedVehicleDetails _collectedVehicleDetails = locator<SellectedVehicleDetails>();

  Api _api = locator<Api>();

  List<Vehicle> _vehicles;

  List<Vehicle> get vehicles => _vehicles;

  get model => _model;
  get make => _make;

  get selectedCar => _selectedCar;

  set setSelectedCar ( var selectedCar){
    return _selectedCar = selectedCar;
  }

  set make (var make){
    _collectedVehicleDetails.vehicleMake = make;
    return _make = make;
  }

  set model( var model){
    return _model = model;

  }
  Future getVehicleData() async {
    setBusy(true);
    _vehicles = await _api.getDataColletions();
    setBusy(false);
    notifyListeners();
  }
}
  

