import 'package:flutter/material.dart';
import 'package:gerente_loja/core/viewmodels/user_viewmodel.dart';
import 'package:gerente_loja/routes/router.gr.dart';
import 'package:gerente_loja/ui/views/brands_screen.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:auto_route/auto_route.dart';

//import 'package:numeric_keyboard/numeric_keyboard.dart';
//import 'package:pistom/app/locator.dart';
//import 'package:pistom/core/viewModels/user_viewmodel.dart';
//import 'package:pistom/ui/views/home_view.dart';
import 'package:gerente_loja/ui/views/signup_view.dart';

import 'package:stacked/stacked.dart';

class OtpView extends StatefulWidget {
  const OtpView({Key key}) : super(key: key);

  @override
  _OtpViewState createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String text = '';

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
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/pexels-photo-1729991.jpeg'),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                        'Insira o código de acesso enviado pro seu telefone',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 26,
                                            fontWeight: FontWeight.w500
                                        )
                                    )
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  constraints:
                                  const BoxConstraints(maxWidth: 500),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      otpNumberWidget(0),
                                      otpNumberWidget(1),
                                      otpNumberWidget(2),
                                      otpNumberWidget(3),
                                      otpNumberWidget(4),
                                      otpNumberWidget(5),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: RaisedButton(
                            onPressed: () {
                              debugPrint(text);

                              //Got to the Login Page.

                             // context.rootNavigator.push(Routes.brandsScreens);

                              model.confirmCode(text, ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => brandsScreens())),
                                      ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => SignUpView()))
                              );
                            },
                            color: Theme.of(context).primaryColor,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Confirmar',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.blueAccent,
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
                          ),
                        ),
                        NumericKeyboard(
                          onKeyboardTap: (value) {
                            WidgetsBinding.instance
                                .addPostFrameCallback((_) {
                              setState(() {
                                text = text + value;
                              });
                            });
                          },
                          textColor: Colors.blueAccent,
                          rightIcon: Icon(
                            Icons.backspace,
                            color: Colors.blueAccent,
                          ),
                          rightButtonFn: () {
                            setState(() {
                              text = text.substring(0, text.length - 1);
                            });
                          },
                          leftIcon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.blueAccent,
                          ),
                          leftButtonFn: () => Navigator.of(context).pop(),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        viewModelBuilder: () => UserViewModel());
  }
  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 8),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
              text[position],
              style: TextStyle(color: Colors.white),
            )),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 4),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      );
    }
  }
}