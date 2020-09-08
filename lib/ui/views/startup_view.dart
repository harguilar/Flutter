import 'package:flutter/material.dart';
import 'package:gerente_loja/core/viewmodels/startup_viewmodel.dart';
import 'package:gerente_loja/locator.dart';
import 'package:gerente_loja/ui/views/brands_screen.dart';
//import 'package:pistom/app/locator.dart';
//import 'package:pistom/core/viewModels/startup_viewmodel.dart';
//import 'package:pistom/ui/views/login_view.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:stacked/stacked.dart';
import '';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return    ViewModelBuilder<StartupViewModel>.reactive(
      disposeViewModel: false,
      //onModelReady: (model) =>model.handleStartUpLogic(),
      builder:(context, model, child) => SplashScreen(
        seconds: 3,
        navigateAfterSeconds: brandsScreens()/*model.handleStartUpLogic()*/,
        title: Text(
          'Pistom Peças & Acessórios',
          style: new TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25.0),
        ),
        imageBackground: AssetImage('assets/images/otpImage.jpg'),
        image: Image.asset('assets/images/logo.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 40.0,
        onClick: () => print("Pistom Angola-Splash Screen"),
        loaderColor: Colors.white,
      ),
      viewModelBuilder: ()=>locator<StartupViewModel>(),
    );
  }
}