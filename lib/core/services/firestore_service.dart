import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:gerente_loja/core/datamodels/user_model.dart';
//import 'package:pistom/core/datamodels/user_model.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
  Firestore.instance.collection("users");

  Future createUser(UserModel user) async {
    try {
      await _usersCollectionReference.document(user.uid).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return UserModel.fromDocument(userData);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future<void> updateUser(UserModel userData) {
    _usersCollectionReference
        .document(userData.uid)
        .updateData(userData.toJson());
  }

  void saveToken() async {
    final token = await FirebaseMessaging().getToken();

    _usersCollectionReference
        .document()
        .collection('tokens')
        .document(token)
        .setData({
      'token': token,
      'updatedAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem,
    });
  }

  Future<DocumentReference> addUserOrder(Map data) {
    _usersCollectionReference
        .document(data['uid'])
        .collection('orders')
        .add(data);
  }
}