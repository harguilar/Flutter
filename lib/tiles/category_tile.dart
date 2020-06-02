import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);
  @override
  Widget build(BuildContext context) {
    //List tiles makes our life easier when we are dealing with Lists.
    return ListTile(
      //leading is little icon where the Image Will be in.
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data['icon']),
      ),
      title: Text(snapshot.data['title']),
      //This will Show the arrow that Displays with your product category
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryScreen(snapshot)),
        );
      },
    );
  }
}
