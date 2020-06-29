import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:gerente_loja/core/models/user.dart';

class UserProvider {
  var ref = Firestore.instance.collection('users');

  final FirebaseAuth _firebaseAuth;

  UserProvider({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> sendOtp(
      String phoneNumber,
      Duration timeOut,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeOut,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  Future<AuthResult> verifyAndLogin(
      String verificationId, String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);

    return _firebaseAuth.signInWithCredential(authCredential);
  }

  Future<FirebaseUser> getUser() async {
    var user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<List<User>> getUsers() async {
    bool connectionState = await DataConnectionChecker().hasConnection;

    List<User> _users;

    if (connectionState) {
      await ref.getDocuments().then((querySnap) {
        _users = querySnap.documents.map((item) {
          return User.fromJson(item.data);
        }).toList();
      });

      return _users;
    } else {
      return List();
    }
  }

  Future<User> getUserById(uid) async {
    bool connectionState = await DataConnectionChecker().hasConnection;

    User user;
    if (connectionState) {
      await ref
          .document(uid)
          .get()
          .then((value) => user = User.fromDocument(value));
      return user;
    } else {
      return null;
    }
  }

  saveUser(User user) async {
    await ref.document().setData(user.toJson());
  }
}
