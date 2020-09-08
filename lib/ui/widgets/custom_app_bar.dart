import 'package:flutter/material.dart';


Widget appBar(BuildContext context, String title ){

  return AppBar(
      title: Text(title,style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),),
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Color.fromRGBO(64, 75, 96, .9) );

}