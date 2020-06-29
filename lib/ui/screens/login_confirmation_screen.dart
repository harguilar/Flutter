import 'package:flutter/material.dart';
import 'package:gerente_loja/core/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'home_screen.dart';

class LoginConfirmationScreen extends StatefulWidget {
  String telefone;
  LoginConfirmationScreen({this.telefone});

  @override
  _LoginConfirmationScreenState createState() => _LoginConfirmationScreenState();
}

class _LoginConfirmationScreenState extends State<LoginConfirmationScreen> {


  final _senCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Validação do Código"),
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
                    controller: _senCodeController,
                    maxLength: 6,
                    maxLines: 1,

                    decoration: InputDecoration(
                      hintText: "Insira o Código  que recebeu no Telefone",

                    ),
                    keyboardType: TextInputType.number,
                    validator: (text) => text.isEmpty || text.length < 6
                        ? "Código inválido"
                        : null,
                    onChanged: (value) {
                      model.phoneNo = value;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),

                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text(
                        "Validar",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Color.fromRGBO(64, 75, 96, .9),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          model.signIn(
                              phone: widget.telefone,
                              smsCode: _senCodeController.text.trim(),
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
    print("Vendedor Criado com Sucesso!");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
  }


}
