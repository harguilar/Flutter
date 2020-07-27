import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/helpers/const_global.dart';

class UserModel extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;
  String sms = "";
  String phoneNo;
  String smsCode;
  String verificationId;
  String uid;
  String email;
  String name;
  String phone;
  String address;

  @override
  void addListener(listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }
  Future<void> signUserUp({VoidCallback onSuccess, VoidCallback onFailed,
    Map<String, dynamic> userData})
  {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      _saveUserData(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      isLoading = false;
      sms = "Ocorreu um erro ao salvar o cadastro de utilizador!";
      onFailed();
      notifyListeners();
    }
  }
  Future<void> signOut() async {
    await _auth.signOut().then((_) {
      print("Saiu");
    });

    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void signIn(
      {@required String phone,
      @required String smsCode,
      @required VoidCallback onSuccess,
      @required Function onFailed}) async {
    print(smsCode);
    isLoading = true;
    notifyListeners();

    bool connectionState = await DataConnectionChecker().hasConnection;
    if (connectionState) {
      try {
        AuthCredential authCredential = PhoneAuthProvider.getCredential(
            verificationId: this.verificationId, smsCode: smsCode);

        isLoading = true;
        notifyListeners();

        await _auth
            .signInWithCredential(authCredential)
            .then((authResult) async {
          firebaseUser = authResult.user;
          sms = "Logado com succeso";
        }).catchError((Exception e) {
          print(e.toString());
          isLoading = false;
          sms = "Ocorreu um erro interno.";
          onFailed();
          notifyListeners();
        });
      } catch (e) {
        print(e.toString());
        sms = "Ocorreu um erro interno, tente mais tarde.";
        onFailed();
        isLoading = false;
        notifyListeners();
      }
    } else {
      sms = "Sem internet";
      onFailed();
      isLoading = false;
      notifyListeners();
    }
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {

    _loadCurrentUser();
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
    ConstGlobal.documentId = firebaseUser.uid;
    notifyListeners();
  }
  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null)
       firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
        ConstGlobal.userData = docUser.data;
      }
    }
    notifyListeners();
  }
}
