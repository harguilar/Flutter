import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Api {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;
  Api (this.path){
    ref = _db.collection(path);
  }
  Future<QuerySnapshot> getDataColletions(){
    return ref.getDocuments();
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