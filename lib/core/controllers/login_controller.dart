import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gerente_loja/ui/screens/home_screen.dart';
import 'package:gerente_loja/ui/screens/loginPage.dart';

class loginController {
  //Handle the Login
  handleAuth(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if (snapshot.hasData){
          return HomeScreen();
        }
        else {
          return LoginPage();
        }
      },
    );
  }
  SignIn (AuthCredential authCreds){
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }
}