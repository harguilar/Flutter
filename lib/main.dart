import 'package:auto_route/auto_route.dart';
import 'package:gerente_loja/ui/views/loginPage.dart';
import 'package:gerente_loja/ui/views/brands_screen.dart';
import 'package:gerente_loja/ui/views/startup_view.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/routes/router.gr.dart' as r;
import 'locator.dart';

void main() {
  //Register Service Models.
  setupLocator();
    runApp(
       MyApp(),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp (

      debugShowCheckedModeBanner: false,

      builder: ExtendedNavigator.builder(

        router: r.Router(),
      ),
      title: 'Piston',
      home: brandsScreens(),
    );
  }
}



