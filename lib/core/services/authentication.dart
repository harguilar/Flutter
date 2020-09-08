import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {

  static GoogleSignInAccount userGoogle;
  //Create an Object to SignIn with Google.
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser _currentuser;

  Future <FirebaseUser> getUserGmail() async {
    //check if current user is Null or not
    if (_currentuser != null ) return _currentuser;

    try {
      //Allow me to login with google. It will get the name, email and photo.
      final GoogleSignInAccount _googleSignAccount = await _googleSignIn.signIn();

      //Assign Value to User Google.
      userGoogle = _googleSignAccount;

      //Create a SignIn for Firebase with google account to validate where is assessing your data.
      final GoogleSignInAuthentication _googleSignInAuthentication = await userGoogle.authentication;

      //userGoogle.authentication

      //Assess the token with SignAuth to authenticate in FireBase
      final AuthCredential _credential = GoogleAuthProvider.getCredential(
          idToken: _googleSignInAuthentication.idToken,
          accessToken: _googleSignInAuthentication.accessToken);

      //Now Login to Firebase
      final AuthResult _authResult = await FirebaseAuth.instance.signInWithCredential(_credential);
      //Now Get the user within Firebase to check what he is accessing
       _currentuser = _authResult.user;

      //if the user it Null we will log in and return the user which logged in
      return _currentuser;
    }
    catch(error){
      print(error);
    }
  }


  //Authentication();
}