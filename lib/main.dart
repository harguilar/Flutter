import 'package:flutter/material.dart';
import 'package:gerente_loja/screens/home_screen.dart';
import 'package:gerente_loja/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PISTOM',
      theme: ThemeData(
        primaryColor: Colors.blueGrey
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      //LoginScreen(),
    );
  }
}