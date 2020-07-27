
import 'package:gerente_loja/core/models/crudModel.dart';
import 'package:gerente_loja/ui/screens/landing_screen.dart';
import 'package:gerente_loja/ui/screens/loginPage.dart';
import 'package:gerente_loja/ui/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'core/controllers/login_controller.dart';
import 'core/controllers/orders_controller.dart';
import 'core/controllers/proformas_controller.dart';
import 'core/controllers/reply_controller.dart';
import 'core/controllers/user_controller.dart';
import 'core/controllers/vehicle_controller.dart';
import 'core/models/user.dart';
import 'locator.dart';
void main() => runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserModel(),
          //create: (_) => UserModel(),
        ),
        // Provider (create: (_) => UserModel()),
        ChangeNotifierProvider(
          create: (_) => VehicleController(),
          //create: (_) => UserModel(),
        ),

        ChangeNotifierProvider(
          create: (_) => locator<CRUDModel>(),
          //create: (_) => UserModel(),
        ),

        Provider (create: (_) => ProformasController()),
        Provider (create: (_) => UserController()),
        Provider (create: (_) => OrdersController()),
        Provider (create: (_) => ReplyController()),
      ],
      child:MyApp(),
    )

  );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      title: 'Piston',
      home: LandingScreen(),
    );
  }
}



