/*
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/core/controllers/proformas_controller.dart';
import 'package:gerente_loja/core/models/proforma_data.dart';
import 'package:gerente_loja/ui/tiles/vendor_quote_tile.dart';
import 'package:gerente_loja/ui/widgets/custom_app_bar.dart';

class VendorProformaHistTab extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final proformasController = BlocProvider.getBloc<ProformasController>();
    proformasController.getProformas();

    return Scaffold(
      appBar: appBar(context, 'Proformas já respondidas'),
      body: StreamBuilder<List<Proforma>>(
          stream: proformasController.outProformas,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else
            if(snapshot.data.length==0){

              return Center(
                child: Text(
                  'Sem Pedidos de Proforma no aplicativo',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              );


            }
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 8.0,
                  margin: new EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration:
                    BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                    child: VendorQuoteTile(snapshot.data[index]),
                  ),
                );
              },
            );
          }),
    );
  }
}
*/
