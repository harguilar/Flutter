import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

//scopped model mantain the state of your user throughout the entire app
class UserModel extends Model{

  //Before Log in Current State.
  bool isLoading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  //Define the User that will be logged in.
  FirebaseUser firebaseUser;

  //Define THe user details in the Form .
  Map <String, dynamic> userData = Map();
  //@required make is easier for us on function call it will
  // force us to call the function with all its parameters.

  void signUp({@required Map <String, dynamic> userData, @required String pass,
    @required VoidCallback onSucess,  @required  VoidCallback onFailure }){
    //Notify the User That is loading.
    isLoading = false;
    notifyListeners();

    //Create a User and Password within Firebase
    _auth.createUserWithEmailAndPassword(
        email: userData['email'],
        password: pass,

    ).then((user) async{
      //This Function will receive the User From Firebase
      //if it is sucessfull Please Assign the User to Firebase User.
      print(userData['email']);
      firebaseUser = user;
      //Save The whole UserData to FireStore
      await _saveUserData(userData);
      onSucess();
      //Say that we are no longer loading
      isLoading = false;
      notifyListeners();
      //notefyListener(false);

    }).catchError((e){
      onFailure();
      isLoading = false;
      notifyListeners();
      //notefyListener(false);
    });
   /* print('Below is the Authentication Needed for it \n');
    print(_auth.createUserWithEmailAndPassword(email: userData['email'], password: pass));*/
  }
  void signIn() async{
    //Set is loading to true once you loging
    //isLoading = true;
    isLoading = true;
    notifyListeners();
   // notefyListener(true);
    //notify listeners so that they know that the state changed.
    //notifyListeners();
   // notifyListeners();
    //After 3 Seconds Away
    await Future.delayed(Duration(seconds: 3));
    isLoading = false;
    notifyListeners();
    //notefyListener(false);
  }
  void recoverPass(){}

  void signOut() async{
    //Sign out user
    await _auth.signOut();
    //Reset User Data so that is empty
    userData = Map();
    //Show that Nobody is logged in
    firebaseUser = null;
    //Notify all the Listers to change State.
    notifyListeners();
  }
  bool isLoggedIn(){
    //check to see if the User is logged in
    //FirebaseUser = userData['name'];
    return firebaseUser !=null;
  }
//Create a User Data Method to Store User info
  Future<Null> _saveUserData(Map<String, dynamic> userData) async{
    this.userData = userData;
    //Create a User Collection with Firebase.
    await Firestore.instance.collection('users').document(firebaseUser.uid).setData(userData);
  }
}

