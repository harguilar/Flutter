import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gerente_loja/core/models/user.dart';
import 'package:gerente_loja/helpers/const_global.dart';
import 'package:gerente_loja/ui/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';



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
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: appBar(context, "CRIAR CONTA"),
        body: Consumer<UserModel>(builder: (context, model, child ) {
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
                  height: 16,
                ),

              SizedBox(height: 16.0,)
                ,
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child:

                    Text(
                      "Criar Conta",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    textColor: Colors.white,
                    color: Color.fromRGBO(64, 75, 96, .9),
                    onPressed: () async {
                      CupertinoAlertDialog(
                        title: Text( "Criar Conta"),
                        content: Text('Escolhe o tipo de Cliente'),
                        actions: [
                          CupertinoDialogAction(child: Text('Buyer'),
                          onPressed:(){
                            _userType = 'Buyer';

                          } ,),
                          CupertinoDialogAction(child: Text('Seller'), onPressed:() {
                            _userType = 'Seller';
                           },
                          ),
                        ],
                      );

                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "userId": ConstGlobal.user.uid,
                          "name": _nameController.text.trim(),
                          "email": _emailController.text.trim(),
                          "phone": widget.phone,
                          "address": _addressController.text.trim(),
                           "role": _userType,
                        };
                        ConstGlobal.userData =userData;

                        model.signUserUp(
                            onSuccess: _onSuccess,
                            onFailed: () {
                              _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text("Falha ao cadastrar os dados do utilizador!"),
                                  )
                              );
                            },
                          userData: userData,
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
    print("Utilizador cadastrado com Sucesso!");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
  }
}
