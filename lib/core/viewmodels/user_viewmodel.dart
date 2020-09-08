import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/core/datamodels/proforma_data.dart';
import 'package:gerente_loja/core/datamodels/user_model.dart';
//import 'package:gerente_loja/constants/route_names.dart';
import 'package:gerente_loja/core/datamodels/user_model.dart';
import 'package:gerente_loja/core/services/api.dart';
import 'package:gerente_loja/core/services/authentication_service.dart';
import 'package:gerente_loja/core/services/cloud_storage_services.dart';
import 'package:gerente_loja/core/services/firestore_service.dart';
import 'package:gerente_loja/core/services/proforma_services.dart';
//import 'package:gerente_loja/core/services/navigation_service.dart' as nav;
import 'package:gerente_loja/core/viewmodels/base_model.dart';
import 'package:gerente_loja/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
//import 'package:stacked_services/stacked_services.dart';

//import '../../app/locator.dart';


//It was BaseModel => BaseViewModel
class UserViewModel extends BaseModel {

  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
 // final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final _snackbarService = locator<SnackbarService>();
 // final nav.NavigationService _navigationService = locator<nav.NavigationService>();


  //final Api _api =locator<Api>();

  final ProformaServices _proformaServices = locator<ProformaServices>();
  final CloudStorageService _cloudStorageService = locator<CloudStorageService>();




  String sms = "";
  String smsCode;
  String phoneNo;
  String verificationId;


  Future<DocumentReference> addUser(Map data) {
    setBusy(true);
    _firestoreService.createUser(UserModel.fromJson(data));
    setBusy(false);
    notifyListeners();
  }

  Future<DocumentReference> addUserOrder(Map data) {
    _firestoreService.addUserOrder(data);
    notifyListeners();

    _snackbarService.showSnackbar(
      message:
      'O seu pedido foi registado com sucesso!Acompanhe o estado do mesmo em pedidos',
      title: 'Pedido Registrado com Sucesso',
      duration: Duration(seconds: 15),
      onTap: (_) {
        print('snackbar tapped');
      },
      mainButtonTitle: 'Undo',
      onMainButtonTapped: () => print('Undo the action!'),
    );

   // _navigationService.navigateTo(OdersViewRoute);
  }

  confirmCode(String code,VoidCallback navToHome,VoidCallback navToSignUp) async {
    try {
      AuthResult result = await _authenticationService.confirmCode(
          code, this.verificationId, this.phoneNo);

      FirebaseUser userResult = result.user;
      if (userResult != null) {
        if (result.additionalUserInfo.isNewUser) {
          print('SIGNUP will be Called');
          //loadCurrentUser();
          //Harguilar
          //saveToken();

          // _navigationService.navigateTo(SingUpViewRoute, arguments: this.phoneNo);
         // context.rootNavigator.push(Routes.loginView);

          //navToSignUp();
        } else {
          print('HOMESCREEN will be Called');
          SharedPreferences.setMockInitialValues({});
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs?.setBool("isLoggedIn", true);
          //loadCurrentUser();
          //Harguilar
          //saveToken();
          navToHome();
          // _navigationService.navigateTo(HomeViewRoute);

        }
      } else {
        print('Error confirming OTP code');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> loginUser(String phone,VoidCallback navToOTP, VoidCallback onFailed) async {

    setBusy(true);
    String imageUrl;
    //String urlImage = _cloudStorageService.urlImage(imageUrl);

   // _proformaServices.saveProforma(urlImage);

    FirebaseAuth _auth = FirebaseAuth.instance;

    debugPrint('loginUser CALLED $phone');

    _auth.verifyPhoneNumber(
        phoneNumber: phone.trim(),
        timeout: Duration(seconds: 60),// code sent expires after 60 seconds

        //callback which gets called once the verification is successfully completed.
        //this callback is called only when the verification is successfully completed automatically
        // using Auto Retrieval (without the need of user input)
        verificationCompleted: (AuthCredential credential) async {
          //_navigationService.pop();
          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
           // _api.loginToQuickblox('Manenga', 'Rasp2025@');
            // _navigationService.navigateTo(HomeViewRoute);
            setBusy(false);
            navToOTP();
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done automaticaly
        },

        //callback which gets called if the verification is failed because of wrong code or incorrect mobile number
        verificationFailed: (AuthException exception) {
          onFailed();
          setBusy(false);
          print('PHONE VERIFICATION FAILED     $exception');

        },
        // codeSent is a callback which gets called if OTP code has not been fetched successfully from user device
        codeSent: (String verificationId, [int forceResendingToken]) async{


          this.verificationId=verificationId;
          this.phoneNo=phone;
          notifyListeners();

          //Sends the user to OTP Screen to enter the code manually
          //_navigationService.navigateTo(OtpViewRoute);
          // setBusy(false);
          navToOTP();
        },
        //codeAutoRetrievalTimeout is the callback which gets called when the time will be completed for the auto retrieval of code
        codeAutoRetrievalTimeout: (String verificationId){
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        }
    );
  }
  static Future<String> getCurrentUserId() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    return user.uid;
  }

  Future<void> updateUser() {

    try{
      setBusy(true);
      _firestoreService.updateUser(currentUser);
      setBusy(false);
      notifyListeners();
      //_navigationService.pop();
      //_navigationService.pop();
      //_snackbarService.showSnackbar(message: 'Dados editados com successo !');

    }
    catch(e){
      _snackbarService.showSnackbar(message: 'Ocorreu um erro, tente mais tarde');

    }
  }
  Future<void> signUserUp(
      {VoidCallback onSuccess, VoidCallback onFailed}) {
    try {
      setBusy(true);
      addUser(this.currentUser.toJson());
      onSuccess();
      setBusy(false);
      notifyListeners();
    } catch (e) {
      print(e);
      setBusy(false);
      sms = "Ocorreu um erro ao salvar o cadastro de utilizador!";
      onFailed();
      notifyListeners();
    }
  }

  void signIn(
      {@required String phone,
        @required String smsCode,
        @required VoidCallback onSuccess,
        @required Function onFailed}) async {
    print(smsCode);
    setBusy(true);
    notifyListeners();

    try {

      setBusy(true);
      notifyListeners();

      _authenticationService.signIn(
          phone: phone,
          smsCode: smsCode,
          onSuccess: onSuccess,
          onFailed: onFailed,
          verificationId: this.verificationId);
      sms = "Logado com succeso";
      debugPrint("Logado com succeso");
    } catch (e) {
      print(e.toString());
      setBusy(false);
      sms = "Ocorreu um erro interno.";
      notifyListeners();
    }
  }

/*
  void getPhoneNumber (String phone){
    _proforma.userID(phone);

  }
  void sendProforma (){
    _proforma.onPressed();
  }
*/

/*  void saveToken() {

    _firestoreService.saveToken();
  }*/
  Future<void> signOut() async {
    _authenticationService.signOut();
    //Harguilar
    notifyListeners();
    //_navigationService.pop();
    //_navigationService.navigateTo(LoginViewRoute);
  }
}