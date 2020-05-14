import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/screens/home_screen.dart';
import 'package:gerente_loja/screens/signup_screen.dart';
import 'package:gerente_loja/widgets/auth_service.dart';

void main() => runApp(
    
    //Firestore.instance.collection('').document('doc').setData({"texto":"daniel"});
    
    MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PISTOM',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        iconTheme: IconThemeData(
          color: Colors.blue
        )
      ),
      debugShowCheckedModeBanner: false,
      home: AuthService().handleAuth(),
      //LoginScreen(),
    );
  }
}