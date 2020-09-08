import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gerente_loja/core/datamodels/proforma_data.dart';
import 'package:gerente_loja/core/viewmodels/user_viewmodel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route.dart';

import 'package:gerente_loja/routes/router.gr.dart';
//import 'package:pistom/app/locator.dart';
import 'package:gerente_loja/ui/views/otp_view.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController phoneController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String phone = '';
 // Proforma _proforma = Proforma(userId: null);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserViewModel>.reactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        //onModelReady: (model) => model.initialise(),
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/pexels-photo-1729991.jpeg'),
                        fit: BoxFit.cover)),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 100),
                                constraints:
                                const BoxConstraints(maxHeight: 100),
                                // margin: const EdgeInsets.symmetric(horizontal: 8),
                                child:
                                Image.asset('assets/images/logo.png')),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Text('Autenticação por Telefone',
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Container(
                              constraints:
                              const BoxConstraints(maxWidth: 500),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                      'Insira seu telefone para aceder',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19)),
                                  TextSpan(
                                      text: ' ',
                                      style: TextStyle(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 17)),
                                  // TextSpan(text: 'Para o ', style: TextStyle(color: Theme.of(context ).primaryColor)),
                                ]),
                              )),
                          Container(
                            height: 40,
                            constraints:
                            const BoxConstraints(maxWidth: 500),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: CupertinoTextField(
                              maxLength: 9,
                              maxLengthEnforced: true,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4))),
                              controller: phoneController,
                              clearButtonMode:
                              OverlayVisibilityMode.editing,
                              keyboardType: TextInputType.phone,
                              maxLines: 1,
                              //  placeholder: '+244...',
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              constraints:
                              const BoxConstraints(maxWidth: 500),
                              child: /*!model.isBusy
                                      ?*/ ArgonButton(
                                height: 50,
                                width: 350,
                                borderRadius: 5.0,

                                onTap: (startLoading, stopLoading, btnState) {
                                  if (phoneController.text.length == 9){

                                    if(btnState == ButtonState.Idle){
                                       phone = phoneController.text;
                                       if (phone != null || phone.isNotEmpty){

                                         startLoading();
                                         model.loginUser(
                                             '+244'+phoneController.text,
                                                 () => context.rootNavigator.push(Routes.otpView), () {
                                           _scaffoldKey.currentState
                                               .showSnackBar(SnackBar
                                             (
                                             behavior:
                                             SnackBarBehavior.floating,
                                             backgroundColor: Colors.red,
                                             content: Text(
                                               'Inseriu telefone inválido.Insira um telefone válido e ativo!',
                                               style: TextStyle(
                                                   color: Colors.white),
                                             ),
                                           )
                                           );
                                         });

                                        //  model.getPhoneNumber(phone);
                                         //_proforma.onPressed();
                                       }



                                      stopLoading();
                                    }

                                  } else {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      behavior:
                                      SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Por favor insira telemóvel válido de 9 dígitos sem +244',
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                    ));
                                  }

                                },
                                color: Theme.of(context).primaryColor,
                                loader: Container(
                                  padding: EdgeInsets.all(10),
                                  child: SpinKitRotatingCircle(
                                    color: Colors.white,
                                    // size: loaderWidth ,
                                  ),
                                ),
                                /* shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(14))),*/
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Continuar',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        padding:
                                        const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(
                                                  20)),
                                          color: Theme.of(context)
                                              .primaryColor,
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            /*: CircularProgressIndicator())*/
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        viewModelBuilder: () => UserViewModel());
  }
}