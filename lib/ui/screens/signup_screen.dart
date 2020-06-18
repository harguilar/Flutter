import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gerente_loja/helpers/const_global.dart';
import 'package:gerente_loja/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  final String phone;
  SignUpScreen({this.phone});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _sentCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //String _errorText=widget.errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("CRIAR CONTA"),
          centerTitle: true,
        ),
        body:
        ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                /*  _errorText==null ? Text(_errorText): Container(),*/
                TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        icon: Icon(FontAwesomeIcons.userCircle),
                        hintText: "Nome Completo"),
                    validator: (text) {
                      if (text.isEmpty) return "Nome vazio!";
                      return null;
                    }),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.envelope),
                      hintText: "E-mail"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@"))
                      return "Email inválido";
                    return null;
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.addressCard),
                      hintText: "Endereço"),
                  validator: (text) {
                    if (text.isEmpty) return "Endereço inválido!";
                    return null;
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _sentCodeController,
                  decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.lock),
                      hintText: "Código enviado"),
                  keyboardType: TextInputType.phone,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Código inválido.";
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child: Text(
                      "Criar Conta",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "userId": ConstGlobal.user.uid,
                          "name": _nameController.text.trim(),
                          "email": _emailController.text.trim(),
                          "phone": widget.phone,
                          "address": _addressController.text.trim()
                        };

                        model.signUpWithSmsCode(
                            smsCode: _sentCodeController.text.trim(),
                            userData: userData,
                            onSuccess: _onSuccess,
                            onFailed: () {
                              _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(model.sms ?? ""),
                                  )
                              );
                            }
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }));
  }

  void _onSuccess() {
    print("Vendedor Criado com Sucesso!");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
  }
}
