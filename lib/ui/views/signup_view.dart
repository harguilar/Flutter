import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gerente_loja/core/viewmodels/user_viewmodel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:gerente_loja/routes/router.gr.dart';
import 'package:gerente_loja/ui/widgets/custom_app_bar.dart';
//import 'package:pistom/app/locator.dart';
//import 'package:pistom/core/datamodels/user_model.dart';
//import 'package:pistom/core/viewModels/user_viewmodel.dart';
//import 'package:pistom/ui/widgets/custom_app_bar.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatefulWidget {
  final String phone;
  SignUpView({this.phone});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserViewModel>.reactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        // onModelReady: (model) => model.initialise(),
        builder: (context, model, child) => Scaffold(
            key: _scaffoldKey,
            appBar:  appBar(context, "Cadastro de cliente"),

            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                      AssetImage('assets/images/pexels-photo-1260727.jpeg'),
                      fit: BoxFit.cover)
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(18.0),
                  children: <Widget>[
                    TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            icon: Icon(
                                FontAwesomeIcons.userCircle,
                                color: Colors.black,
                                size: 25
                            ),
                            //hintText: "Nome Completo",
                            labelText: "Nome Completo",
                            labelStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)
                        ),
                        validator: (text) {
                          if (text.isEmpty) return "Nome vazio!";
                          return null;
                        }
                    ),
                    SizedBox(height: 18.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        icon: Icon(
                          FontAwesomeIcons.envelope,
                          color: Colors.black,
                          size: 25,
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text.isEmpty || !text.contains("@"))
                          return "Email inválido";
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        icon: Icon(
                            FontAwesomeIcons.addressCard,
                            color: Colors.black,
                            size: 25
                        ),
                        labelText: "Endereço",
                        labelStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                      validator: (text) {
                        if (text.isEmpty) return "Endereço inválido!";
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
                          "Criar conta",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        textColor: Colors.white,
                        color: Color.fromRGBO(64, 75, 96, .9),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            model.currentUser.uid = await UserViewModel.getCurrentUserId();
                            model.currentUser.name=_nameController.text.trim();
                            model.currentUser.email= _emailController.text.trim();
                            model.currentUser.phoneNo=widget.phone;
                            model.currentUser.address = _addressController.text.trim();


                            model.signUserUp(
                                onSuccess: _onSuccess,
                                onFailed: _onFailed
                            );
                            //harguilar
                           // model.saveToken();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )),
        viewModelBuilder: () => UserViewModel());
  }

  void _onFailed() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao cadastrar os dados do utilizador!"),
    ));
  }

  void _onSuccess() {
    print("Utilizador cadastrado com Sucesso!");
    context.rootNavigator.push(Routes.brandsScreens);

   /* Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeView()),
            (Route<dynamic> route) => false);*/
  }
}