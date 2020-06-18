import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/ui/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'core/controllers/proformas_controller.dart';
import 'core/controllers/user_controller.dart';
import 'core/controllers/vehicle_controller.dart';
import 'core/models/user.dart';


void main() => runApp(

    //Firestore.instance.collection('').document('doc').setData({"texto":"daniel"});

    MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return BlocProvider(
            blocs: [
              Bloc((x) => VehicleController()),
              Bloc((x) => ProformasController()),
              Bloc((x) => UserController())
            ],
            child: MaterialApp(
              title: 'PISTOM',
              theme: ThemeData(
                  primaryColor: Colors.blueGrey,
                  iconTheme: IconThemeData(color: Colors.blue)),
              debugShowCheckedModeBanner: false,
              home: LoginScreen(),
              //LoginScreen(),
            ),
          );
        },
      ),
    );
  }
}
