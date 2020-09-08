
class SellectedVehicleDetails {

  String _vehicleMake;
  String _vehicleChassisNumber;
  String _vehicleModel;
  String _vehicPartName;


  get vehicleChassi => _vehicleChassisNumber;
  get vehicleMake => _vehicleMake;
  get vehicleModel => _vehicleModel;
  get vehiclePartName => _vehicPartName;


  set vehicleChassi (var chassiNumber){
    return _vehicleChassisNumber = chassiNumber;
  }

  set vehicleMake( var vehicleMake){
    print ('Make Inside the class ' + vehicleMake);
    return _vehicleMake = vehicleMake;
  }


  set vehicleModel(var vehicleModel){
    _vehicleModel = vehicleModel;
  }

  set vehiclePartName(var partName){
    return _vehicPartName = partName;
  }
}