import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/screens/quote_screen.dart';


class QuoteTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  QuoteTile(this.snapshot);


  @override
  Widget build(BuildContext context) {

    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Image.network(
            snapshot.data['images'][0],
            fit: BoxFit.cover,
          )
        ),
        title: Text(
          snapshot.data['vehicle'],
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text(snapshot.data['partName'], style: TextStyle(color: Colors.white))
          ],
        ),
        onTap: (){

          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>QuoteScreen(snapshot) )
          );
        },
        onLongPress: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>QuoteScreen(snapshot) )
          );
        },
        trailing:
        Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)

    );
  }


}

