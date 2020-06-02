import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/tiles/category_tile.dart';
import 'package:jeilaonlinestore/tiles/category_tile.dart';

class ProductTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //This is Future that is used collect Data from The Firebase.
    //return FutureBuilder Because We want to collection information from teh
    return FutureBuilder<QuerySnapshot>(
      //Read The Information from the Products in the DB.
      //Each Document wihin DB is a Category
      future: Firestore.instance.collection('products').getDocuments(),
      builder:(context,snapshot){
        if (!snapshot.hasData){
          //Return the Circular Progress Bar
          return Center(child: CircularProgressIndicator(),);
        } else {
          //Create Divider Between Products or define the List Tiles.
          var dividerTiles = ListTile.divideTiles(tiles:  snapshot.data.documents.map(
                  (documentSnapShot){
                return CategoryTile(documentSnapShot);
              }
          ).toList(),
          color: Colors.grey[500]).toList();
          return ListView(
            //This Will Get each Document. Place them Into Category Tile and Return a List
            children: dividerTiles,
          );
        }
      },
    );
  }
}
