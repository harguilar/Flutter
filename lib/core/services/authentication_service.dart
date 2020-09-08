import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/core/datamodels/user_model.dart';
import 'package:gerente_loja/locator.dart';
//import 'package:pistom/core/datamodels/user_model.dart';
import 'firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  CollectionReference refUsers;
  FirestoreService _firestoreService = locator<FirestoreService>();
  FirebaseUser firebaseUser;
  UserModel _currentUser;
  UserModel get currentUser => _currentUser;

  AuthenticationService() {
    refUsers = _db.collection('users');
  }

  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      return _currentUser = await _firestoreService.getUser(user.uid);
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    await _populateCurrentUser(user);
    return user != null;
  }

  Future<String> getUserID() async {
    var user =
    await _firebaseAuth.currentUser(); // Populate the user information
    return user.uid;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut().then((_) {
      print("Utilizador fez signOut");
    });

    //userData = Map();
    firebaseUser = null;
  }

  void signIn(
      {@required String phone,
        @required String smsCode,
        @required VoidCallback onSuccess,
        @required Function onFailed,
        @required String verificationId}) async {
    print(smsCode);

    bool connectionState = await DataConnectionChecker().hasConnection;

    if (connectionState) {
      AuthCredential authCredential = PhoneAuthProvider.getCredential(
          verificationId: verificationId, smsCode: smsCode);

      await _firebaseAuth
          .signInWithCredential(authCredential)
          .then((authResult) async {
        firebaseUser = authResult.user;
        await _populateCurrentUser(firebaseUser);
        // sms = "Logado com succeso";
        debugPrint("Logado com succeso");
      }).catchError((Exception e) {
        print(e.toString());
        // sms = "Ocorreu um erro interno.";
        debugPrint("Ocorreu um erro interno ao fazer signUp");
        onFailed();
      });
    } else {
      onFailed();
    }
  }

  //Confirm OTP code sent to user phone

  Future<AuthResult> confirmCode(
      String code, String verificationId, String phone) async {
    AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);

    AuthResult result = await _firebaseAuth.signInWithCredential(credential);
    await _populateCurrentUser(result.user);

    return result;
  }
}