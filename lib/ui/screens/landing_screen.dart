import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/core/services/api.dart';
import 'package:nice_button/nice_button.dart';

import 'brands_screen.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Solicitar Proforma'),
        centerTitle: true,
        //backgroundColor: Colors.blueGrey,
      ),
      body:
      Center(
        child: FutureBuilder(
          future: Api('home').getDataColletions(),
            builder: (context, snapshot){
            if (!snapshot.hasData){
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.green),
                ),
              );
            }
            else {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index){
                  return Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 16.0),
                          Card(
                            child: AspectRatio(
                              aspectRatio: 0.8,
                              child: Image.network(
                                snapshot.data.documents[index]['image'],
                                height: 500,
                                //width: 300,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          NiceButton(
                            //child: Text(''),
                            width: 255,
                            //elevation: 8.0,
                            radius: 52.0,
                            text: 'Solicitar',
                            textColor: Colors.black,
                            background: Colors.white,
                            onPressed: (){
                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BrandsScreens()));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
              );
             }
          }
        ),
      ),
    );
  }
}
