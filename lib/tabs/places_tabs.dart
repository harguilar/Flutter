import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/tiles/place_tile.dart';

class PlacesTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder <QuerySnapshot>(
      //Get all the Stores.
      future: Firestore.instance.collection('places').getDocuments(),
      builder: (context, snapshot){
        if (!snapshot.hasData){
          return Center (child: CircularProgressIndicator());
        }
        else
          return ListView (
            //Convert The Document into a list
            children: snapshot.data.documents.map((doc) => PlaceTile(doc)).toList(),
          );
      },

    );
  }
}
