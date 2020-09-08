import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:gerente_loja/core/datamodels/vehicle.dart';
/*import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/models/qb_session.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';*/

class Api {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;
  Api (this.path){
    ref = _db.collection(path);
  }
  Future getDataColletions() async {
    try {
      var vehicleDocuments = await ref.getDocuments();
      if (vehicleDocuments.documents.isNotEmpty){
        //Converting the Query SnapShot Into List.
        return vehicleDocuments.documents.map((e) => Vehicle.fromDocument(e)).toList();
      }
    }
    catch (e) {
      debugPrint(e);
    }
    //return ref.getDocuments();
  }
  Stream<QuerySnapshot> streamDataCollection(){
    return ref.snapshots();
  }
  Future<DocumentSnapshot> getDocumentById(String id){
    return ref.document(id).get();
  }
  Future<DocumentSnapshot>removeDocumentById(String id){
    ref.document(id).delete();
  }
  Future<void> updateDocument(Map data, String id){
    return ref.document(id).updateData(data);
  }
  Future<DocumentReference>addDocument(Map data){
    return ref.add(data);
  }

}