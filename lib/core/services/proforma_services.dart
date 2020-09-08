import 'package:gerente_loja/core/datamodels/proforma_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerente_loja/core/viewmodels/cloud_storage_result.dart';
import 'package:gerente_loja/locator.dart';

class ProformaServices{
  final _db = Firestore.instance;
  ProformaData _dataSet;

  void saveProforma(String url) async{
    _db.collection("proformas").add(
        {
          //"make" :userId,
          "make" :_dataSet.make,
          "model":_dataSet.model,
          "peca" : _dataSet.peca,
          "chassis":_dataSet.vinNumber,
          'image': url,
        }).then((value){
      print("success!");
    });
  }


  void setProforma(ProformaData objSet){
    _dataSet = objSet;
  }
}