import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/core/models/user.dart';
import 'package:gerente_loja/helpers/const_global.dart';
import 'package:gerente_loja/ui/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'dart:developer' as dev;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String smsCode = "";
  String phoneNumber = '';
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //Future<bool> loginUser(String phone, BuildContext context) async {
    Future<bool> loginUser(String phone) async {

      FirebaseAuth _auth = FirebaseAuth.instance;
      _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 120),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();
          AuthResult result = await _auth.signInWithCredential(credential);
          FirebaseUser user = result.user;

          if (user != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return AlertDialog(
                  title: Text("Insira o código enviado"),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        inputFormatters: [LengthLimitingTextInputFormatter(6)],
                        keyboardType: TextInputType.number,
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirmar"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        try {
                          final code = _codeController.text.trim();
                          AuthCredential credential =
                              PhoneAuthProvider.getCredential(
                                  verificationId: verificationId,
                                  smsCode: code);
                          AuthResult result =
                              await _auth.signInWithCredential(credential);
                          FirebaseUser user = result.user;
                          if (user != null) {
                            ConstGlobal.user = user;
                            if (result.additionalUserInfo.isNewUser) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen(phone:_phoneController.text)));
                            } else {

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            }
                          } else {
                            // Navigator.of(context, rootNavigator: true).pop(result);
                          }
                        } catch (e) {
                          print(e.message);
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  } //loginUser

  @override
  Widget build(BuildContext context) {
   // final userModel = Provider.of<UserModel>(context);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Autenticação"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        ),
        body: StreamBuilder<DataConnectionStatus>(
          stream: DataConnectionChecker().onStatusChange,
          builder: (context, snapshot) {
            if (snapshot.data == DataConnectionStatus.disconnected) {
              return Center(
                  child: Text(
                'Sem internet.Ligue a sua internet',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ));
            } else
              return Consumer<UserModel>(
                builder: (context, model, child) {
                  /*if (model.isLoading)
                    return Center(
                      child: CircularProgressIndicator(),
                    );*/
                  return Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.all(16.0),
                      children: <Widget>[
                        TextFormField(
                          controller: _phoneController,
                          decoration:
                              InputDecoration(hintText: "Insira seu Telefone"),
                          keyboardType: TextInputType.number,
                          validator: (text) =>
                              text.isEmpty /*|| !text.contains("9")*/
                                  ? "Digite um número valído incluindo +244"
                                  : null,
                          onChanged: (value) {
                                    //print(model.phoneNo);
                            phoneNumber = value;
                          },
                        ),

                        SizedBox(
                          height: 16.0,
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
                            onPressed: () async {
                              if (phoneNumber != null) {
                               // final phone = _phoneController.text.trim();
                                //Harguilar
                                //loginUser(phone, context);
                                print (phoneNumber);
                                loginUser(phoneNumber);

                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
          },
        ));
  }
  void _onSuccess() {
    print("Cliente existe de facto na Firebase Database!");

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false);
  }


}
