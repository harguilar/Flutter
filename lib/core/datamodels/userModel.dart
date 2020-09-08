import 'package:flutter/material.dart';
import 'package:gerente_loja/ui/views/loginPage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class UserModelProvider extends ChangeNotifier{

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isUserSignedIn;

  Future<FirebaseUser>handleSignIn(isUserSignedIn, _auth) async {
    FirebaseUser user;
    bool userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
      notifyListeners();
    });
    if (isUserSignedIn) {
      user = await _auth.currentUser();
      notifyListeners();
    }
    else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      user = (await _auth.signInWithCredential(credential)).user;
      userSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        isUserSignedIn = userSignedIn;
        notifyListeners();
      });
    }
    return user;
  }
  void checkIfUserIsSignedIn() async {
    var userSignedIn = await _googleSignIn.isSignedIn();
    setState(() {
      isUserSignedIn = userSignedIn;
      notifyListeners();
    });
  }
/*  void onGoogleSignIn(BuildContext context) async {
   // final userLoginModel = Provider.of<UserModelProvider>(context);

    // FirebaseUser user = await _handleSignIn();
    FirebaseUser user = await handleSignIn(isUserSignedIn, _auth);
    var userSignedIn = await Navigator.push(
      context,
     *//* MaterialPageRoute(
          builder: (context) =>
           //   WelcomeUserWidget(user, _googleSignIn)),
    );*//*
    setState(() {
      isUserSignedIn = userSignedIn == null ? true : false;
    });
    notifyListeners();
  }*/
  void setState(Null Function() param0) {
    notifyListeners();
  }
}

