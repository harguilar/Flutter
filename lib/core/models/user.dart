import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/helpers/const_global.dart';
import 'package:gerente_loja/ui/screens/login_confirmation_screen.dart';
import 'package:gerente_loja/ui/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;
  String sms = "";

  String phoneNo;
  String smsCode;
  String verificationId;

  @override
  void addListener(listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  Future<void> verifyPhone(
      {String phone,
        VoidCallback onSuccess,
        VoidCallback onFailed,
        BuildContext context}) async {
    isLoading = true;
    notifyListeners();

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent =
        (String verId, [int forceCodeResend]) async {
      await Firestore.instance.collection("users").getDocuments().then((users) {
        List<DocumentSnapshot> dados = users.documents
            .where((x) => x.data["phone"].toString() == phone)
            .toList();

        if (dados.length == 1) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LoginConfirmationScreen(
                telefone: phone,
              )
          )
          );
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SignUpScreen(
                phone: phone,
              )
          )
          );
        }
      });

      this.verificationId = verId;
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential user) {
      print("Verificado");
    };

    final PhoneVerificationFailed verifiedFailed = (AuthException exception) {
      print('${exception.message}');
      sms = "O código não foi enviado, tente mais tarde.";
      onFailed();
      notifyListeners();
    };

    await _auth
        .verifyPhoneNumber(
        phoneNumber: "+244" + phone,
        codeAutoRetrievalTimeout: autoRetrieve,
        forceResendingToken: 1,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiedFailed)
        .then((value) {
      print("Ook");
      isLoading = false;
      sms = "Código enviado com sucesso";
      notifyListeners();
    }).catchError((e) {
      print("erro");
      isLoading = false;
      sms = "Código não foi enviado com sucesso";
      onFailed();
      notifyListeners();
    });
  }

  Future<void> signUpWithSmsCode(
      {String smsCode,
        Map<String, dynamic> userData,
        VoidCallback onSuccess,
        VoidCallback onFailed}) async {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: this.verificationId, smsCode: smsCode);


    await _auth.signInWithCredential(authCredential).then((authResult) {
      firebaseUser = authResult.user;
      ConstGlobal.userData = userData;
      ConstGlobal.user = authResult.user;
      _saveUserData(userData);
      sms = "Logado com succeso";
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((Exception e) {
      print(e.toString());
      isLoading = false;
      sms = "Ocorreu um erro interno.";
      onFailed();
      notifyListeners();
    });
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

        await _auth.signInWithCredential(authCredential).then((authResult) async {
          firebaseUser = authResult.user;
          sms = "Logado com succeso";

          await Firestore.instance
              .collection("users")
              .getDocuments()
              .then((users) {
            List<DocumentSnapshot> dados = users.documents
                .where((x) => x.data["phone"].toString() == phone)
                .toList();

            ConstGlobal.userData = dados.first.data;
            ConstGlobal.documentId = dados.first.documentID;
            ConstGlobal.user = authResult.user;

            onSuccess();
            isLoading = false;
            notifyListeners();
          });
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
    this.userData = userData;
    await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .setData(userData);

    ConstGlobal.documentId = firebaseUser.uid;
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .get();

        userData = docUser.data;
      }
    }

    notifyListeners();
  }
}
