import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/core/controllers/login_controller.dart';
import 'dart:developer' as dev;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String phoneNumber, verificationId;
  @override
  Widget build(BuildContext context) {
   // dev.debugger();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              //controller: _phoneController,
              decoration:
              InputDecoration(hintText: "Insira seu Telefone"),
              keyboardType: TextInputType.phone,
              onChanged: (value){
                setState(() {
                  this.phoneNumber = value;
                });
              },
            ),

            SizedBox(
              height: 44.0,
              child: RaisedButton(

                child: Text(
                  "Verificar",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                textColor: Colors.white,
                color: Color.fromRGBO(64, 75, 96, .9),
                onPressed: (){

                  verifyPhone(phoneNumber);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> verifyPhone(phoneNumber) async {
    //Create a Credential Verification Sucessful
    final PhoneVerificationCompleted verified = (AuthCredential authResult){
      final verifyLogin = loginController();
      verifyLogin.SignIn(authResult);


    };

    //Create Credentail Verificaton Failure
    final PhoneVerificationFailed verificationFailed = (AuthException authException){
      print ('${authException.message}');
    };
    // Verify Sent SMS.
    final PhoneCodeSent smsSent =  (String verId, [int forceResend]){
      this.verificationId = verId;
    };
    //Get the code and Fill in the Text Box
    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId){
      this.verificationId = verId;

    };

    await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }
}
