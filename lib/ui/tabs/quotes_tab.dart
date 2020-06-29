import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/core/controllers/proformas_controller.dart';
import 'package:gerente_loja/core/models/proforma.dart';
import 'package:gerente_loja/ui/widgets/quote_tile.dart';



class QuotesTab extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final proformasController = BlocProvider.getBloc<ProformasController>();
    proformasController.getProformas();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pistom-Pedidos de Proformas'
          ,style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),

      ),
      body: StreamBuilder<List<Proforma>>(
          stream: proformasController.outProformas,
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
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 8.0,
                    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9) ),
                      child: QuoteTile(snapshot.data[index]),
                    ),
                  );

                },
              );
          }),


    );


  }


}