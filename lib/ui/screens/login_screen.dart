import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:gerente_loja/core/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String smsCode = "";

  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Autenticação por Telefone"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(64, 75, 96, .9),

        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: "Digite seu telefone para continuar"),
                    keyboardType: TextInputType.number,
                    validator: (text) => text.isEmpty/*|| !text.contains("9")*/
                        ? "Digite um número valído"
                        : null,
                    onChanged: (value) {
                      model.phoneNo = value;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),

                  SizedBox(
                    height: 16.0,
                  ),

                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text(
                        "Enviar",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color:Color.fromRGBO(64, 75, 96, .9),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await model.verifyPhone(
                              context: context,
                              phone: _emailController.text.trim(),
                              onSuccess: _onSuccess,
                              onFailed: () {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(model.sms ?? ""),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                ));
                              });
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  void _onSuccess() {
    print("Cliente Criado com Sucesso!");
    Flushbar(
      title: "CLIENTE CRIADO  COM SUCESSO ",
      message:
      "Cliente Criado com Sucesso!",
      duration: Duration(seconds: 6),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.BOTTOM,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
    )..show(context);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
  }
}