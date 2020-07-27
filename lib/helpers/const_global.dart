import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerente_loja/core/models/user.dart';
import 'package:gerente_loja/core/models/user_profile.dart';

class ConstGlobal {
  static FirebaseUser user;
  static File img;
  static Map<String, dynamic> userData = Map();
  static String documentId = "";
  static FirebaseAuth _auth;
  // bool isVendorUser;

  static Future<FirebaseUser> getCurrentUser() async {
    _auth = FirebaseAuth.instance;
    user = await _auth.currentUser();
    //final uid = user.uid;

    return user;
  }

  static Future<bool> isVendor() async {
    final FirebaseUser fBaseUSER = await FirebaseAuth.instance.currentUser();

    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('role', isEqualTo: 'vendor')
        .getDocuments();

    final List<DocumentSnapshot> documents = result.documents;

    return documents.firstWhere(
            (element) => element.data['userId'] == fBaseUSER.uid,
            orElse: () => null) !=
        null;
  }

  static Future<UserProfile> getUserProfile(){
    UserProfile theUser;

    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('users')
          .where('userId', isEqualTo: user.uid)
          .snapshots()
          .listen((data) {
        print('getting user profile');
        theUser = UserProfile(user.uid, data.documents[0]['name'],
            data.documents[0]['email'], data.documents[0]['phone'], data.documents[0]['address']);


        print('Sucessfully got user profile from database');

        print(theUser.address);

        return theUser;
      });
    }).catchError((e) {
      print("Aconteceu um erro");
      print(e.message);
    });
  }
}
