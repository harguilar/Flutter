import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class ConstGlobal {
  static FirebaseUser user;
  static File img;
  static Map<String, dynamic> userData = Map();
  static String documentId = "";
  static  FirebaseAuth _auth;




  static Future<FirebaseUser>  getCurrentUser() async {


    _auth = FirebaseAuth.instance;
    user = await _auth.currentUser();
    //final uid = user.uid;

    return user;
  }



}