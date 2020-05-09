import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/tiles/quote_tile.dart';


class QuotesTab extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("quotes").getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Text('Não há novos Pedidos de Proforma',
                style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            );
          else
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                //return makeCard(snapshot.data.documents[index]);
                return Card(
                  elevation: 8.0,
                  margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9) ),
                    child: QuoteTile(snapshot.data.documents[index]),
                  ),
                );

              },
            );
        });
  }


}
