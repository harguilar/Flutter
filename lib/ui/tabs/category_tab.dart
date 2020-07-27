import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);
  @override
  Widget build(BuildContext context) {
    //List tiles makes our life easier when we are dealing with Lists.
    return Scaffold(
      body: Expanded(
        child: Column(
          children: [
            ListTile(
              //leading is little icon where the Image Will be in.
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(snapshot.data['icon']),
              ),
              title: Text(snapshot.data['make']),
              //This will Show the arrow that Displays with your product category
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: (){

              },
            ),
          ],
        ),
      ),
    );
  }
}
