import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerente_loja/core/models/proforma.dart';
import 'package:gerente_loja/core/models/reply_data.dart';
import 'package:gerente_loja/core/models/vehicle.dart';
import 'package:gerente_loja/core/models/vehicle_user.dart';
import 'package:gerente_loja/core/providers/proformas_provider.dart';
import 'package:gerente_loja/core/providers/vehicles_provider.dart';




class Repository {
  final CollectionReference collection = Firestore.instance.collection('proformas');
  ProformasProvider _proformasProvider = ProformasProvider();
  VehiclesProvider _vehiclesProvider = VehiclesProvider();


  Future<List<Proforma>> getProformas() =>
      _proformasProvider.getProformas();


  Future<List<Vehicle>> geVehicles() => _vehiclesProvider.getVehicles();

  Future<List<VehicleUser>> getVehicleByUser() =>
      _vehiclesProvider.getVehicleByUser();

 // Future<List<Vehicle>> geVehicles() => _vehiclesProvider.getVehicles();

  Future<Vehicle> getVehicleById(String vId) => _vehiclesProvider.getVehicleById(vId);


  //nhsdhglhsghshgjhhgj hrheçrhhoh o4oitjhiojekjfkjfklwljfl jwejtiowjtoijwejtpowtihwe

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addQuote(Proforma proformaModel) {
    return collection.add(proformaModel.toJson());
  }
  Future<DocumentReference> addQuoteReply(Reply reply) {
    return collection.add(reply.toJson());
  }

  updateQuote(Proforma proformaModel) async {
    await collection.document(proformaModel.userId).setData(proformaModel.toJson() ,merge: true);
  }

  addReply(Reply reply,Proforma proformaModel) async{

    await collection.document(proformaModel.userId).collection('replies').document(reply.vendorId).setData(reply.toJson());

  }
}

