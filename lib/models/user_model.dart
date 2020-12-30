import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

//scopped model mantain the state of your user throughout the entire app
class UserModel extends Model{
  //Before Log in Current State.
  bool isLoading = false;

  //Allow us to access from Anywhere the Users Model Without Creating Scoped Models.
  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

 // The add Listernes is like form load when the App Opens you can load staff.
  @override
  void addListener(VoidCallback listener){
    super.addListener(listener);
    _loadCurrentUser();
  }

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
      //if it is successful Please Assign the User to Firebase User.
      print(userData['email']);
      firebaseUser = user;
      //Save The whole UserData to FireStore
      await _saveUserData(userData);
      onSucess();
      //Say that we are no longer loading
      isLoading = false;
      notifyListeners();

    }).catchError((e){
      onFailure();
      isLoading = false;
      notifyListeners();
    });
   /* print('Below is the Authentication Needed for it \n');
    print(_auth.createUserWithEmailAndPassword(email: userData['email'], password: pass));*/
  }
  void signIn({@required String email, @required String pass,
    @required VoidCallback onSucess,  @required  VoidCallback onFailure }) async{
    //Set is loading to true once you loging
    //isLoading = true;
    //isLoadding is just processing

   // signOut();

    //isLoading = true;
    notifyListeners();

    //Sign in with Email and Password.
    _auth.signInWithEmailAndPassword(
        email: email,
        password: pass
    ).then((user) async{
      firebaseUser = user;

      //Load the Current User To display which User is logged in.
      await _loadCurrentUser();
      //Get Back to Main Page once You already Logined
      onSucess();
      isLoading = false;
      notifyListeners();
    }).catchError((e){
      isLoading = false;
      notifyListeners();
      onFailure();
    });
  }
  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  void signOut() async{
    //Sign out user
    await _auth.signOut();
    //Reset User Data so that is empty
    userData = Map();
    //Show that Nobody is logged in
    firebaseUser = null;
    //Notify all the Listerns to change State.
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
  //Create a Method Null only to load the info rom user.
  Future<Null> _loadCurrentUser() async {
    //Check if there is no logged in user
    if (firebaseUser ==  null)
      //Get the Current User
      firebaseUser = await _auth.currentUser();
      if (firebaseUser != null){
        //Check if user Data is not empty
        if(userData['name'] == null){
          //Get the User from Firestore
          DocumentSnapshot docUser = await Firestore.instance.collection('users').document(firebaseUser.uid).get();
          //Assign User to Userdata
          userData = docUser.data;
        }
      }
      //Notify that we already have the User Data loaded
      notifyListeners();

  }
}

