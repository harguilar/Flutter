import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/widgets/auth_service.dart';
import 'package:pin_code_fields/pin_code_fields.dart';




class LoginScreenOTP extends StatefulWidget {

  @override
  _LoginScreenOTPState createState() => _LoginScreenOTPState();
}

class _LoginScreenOTPState extends State<LoginScreenOTP> {


  final formKey = new GlobalKey<FormState>();
  String phoneNo;
  String smsCode;
  String verificationId;
  bool codeSent=false;
  String _errorMessage ="";
  // StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              codeSent ? Container():
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Insira o  telefone com +244',labelStyle: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,fontSize: 20.0)),
                    onChanged: (val) {
                      setState(() {
                        this.phoneNo = val;
                      });
                    },
                  )),
              codeSent ?
              Column(
                children: <Widget>[
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                    child: RichText(
                      text: TextSpan(
                          text: "Insira o código enviado para ",
                          children: [
                            TextSpan(
                                text: this.phoneNo,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25)),
                          ],
                          style: TextStyle(color: Colors.black54, fontSize: 15)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: PinCodeTextField(
                        enableActiveFill: true,
                        length: 6,
                        obsecureText: false,
                        animationType: AnimationType.fade,
                        shape: PinCodeFieldShape.box,
                        animationDuration: Duration(milliseconds: 300),
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        onChanged: (val) {
                          setState(() {
                            this.smsCode = val;
                          });
                        },
                      )),
                  SizedBox(height: 10.0,),
                  Text(_errorMessage),

                ],
              )

                  : Container(),
              SizedBox(height: 15.0,),
              Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: RaisedButton(
                    color: Theme.of(context).secondaryHeaderColor,
                    child: Center(child: codeSent ? Text('Entrar',style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,fontSize: 20.0)):Text('VERIFICAR',style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,fontSize: 20.0),)),
                    onPressed: () {
                      codeSent ? AuthService().signInWithOTP(smsCode, verificationId):
                      verifyPhone(phoneNo);
                    }),


              )
            ],
          )),
    );

  }


  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');

    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }


}
