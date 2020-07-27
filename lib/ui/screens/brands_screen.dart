import 'package:flutter/material.dart';
import 'package:gerente_loja/core/services/api.dart';
class BrandsScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecionar a Marca do Carro'),
        //backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: FutureBuilder(
          future: Api('vehicle').getDataColletions(),
            builder: (context, snapshot){
              if (!snapshot.hasData){
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blueGrey),
                  ),
                );
              }
              else {
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, index){
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: InkWell(
                          splashColor: Colors.blueGrey,
                          child: Card(
                            //color: Colors.blueGrey,
                            child: ListTile(
                              leading: AspectRatio(
                                aspectRatio: 0.8,
                                child: Image.network(
                                  snapshot.data.documents[index]['icon'],
                                  height: 500,
                                  //width: 300,
                                  fit: BoxFit.contain,
                                )
                              ),
                              title: Text(snapshot.data.documents[index]['make'],
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 18.0,
                                  fontWeight: FontWeight.bold,),
                              ),
                              onTap: (){
                              } ,
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    },
                  );
              }
            }
        ),
      ),
    );
  }
}
