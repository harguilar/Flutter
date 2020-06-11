import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/models/user_model.dart';
import 'package:jeilaonlinestore/screens/login_screen.dart';
import 'package:jeilaonlinestore/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()){
      //Get the Id of the User
      String uid = UserModel.of(context).firebaseUser.uid;
      //Get all the User Orders
      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('users').document('uid')
        .collection('orders').getDocuments(),
        builder: (context, snapshot){
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return ListView(
              //Convert FireBase Document Into Order Tile
              children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList(),
            );
          }
        },

      );
    }
    else{
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon (Icons.view_list,
              size: 80.0, color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 16.0,),
            Text("Log in to Add Products",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0,),
            RaisedButton(
              onPressed:(){
                //GO to Log In Screen
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>LoginScreen())
                );
              } ,
              child: Text( "Log in",
                style: TextStyle(fontSize: 18.0),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
            ),

          ],
        ),
      );


    }
  }
}
