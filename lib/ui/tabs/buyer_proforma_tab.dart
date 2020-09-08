/*
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/core/controllers/proformas_controller.dart';
import 'package:gerente_loja/core/models/proforma_data.dart';
import 'package:gerente_loja/helpers/const_global.dart';
import 'package:gerente_loja/ui/tiles/buyer_quote_tile.dart';
import 'package:gerente_loja/ui/tiles/vendor_quote_tile.dart';
import 'package:gerente_loja/ui/widgets/custom_app_bar.dart';

class BuyerProformaTab extends StatefulWidget {
  ProformasController proformasController;

  BuyerProformaTab();

  //const BuyerProformaTab({Key key}) : super(key: key);

  @override
  _BuyerProformaTabState createState() => _BuyerProformaTabState();
}

class _BuyerProformaTabState extends State<BuyerProformaTab> {
  // final proformasController = BlocProvider.getBloc<ProformasController>();

  @override
  Widget build(BuildContext context) {
    widget.proformasController.getProformas();

    return Scaffold(
      appBar: appBar(context, 'Estado das suas Proformas'),
      body: StreamBuilder<List<Proforma>>(
          stream: widget.proformasController.outProformas,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child:
                      CircularProgressIndicator() */
/*Text('Você ainda não solicitou  Proformas',
                  style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),*//*

                  );
            } else if (snapshot.data.length == 0)
              return Center(
                child: Text(
                  "Ainda não solicitou proformas!",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0),
                ),
              );
            else
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
                        decoration: snapshot.data[index].status == 1
                            ? BoxDecoration(
                                color: Color.fromRGBO(64, 75, 120, .9))
                            : BoxDecoration(
                                color: Color.fromRGBO(64, 75, 96, .9)),
                        child: FutureBuilder(
                          future: ConstGlobal.isVendor(),
                          builder: (context, AsyncSnapshot<bool> result) {
                            if (!result.hasData)
                              return Container(
                                color: Colors.amber,
                              );
                            if (result.data)
                              return VendorQuoteTile(snapshot.data[index]);
                            else
                              return BuyerQuoteTile(snapshot.data[index]);

                            ;
                          },
                        )),
                  );
                },
              );
          }),
    );
  } //build

*/
/*  @override
  void dispose() {
    proformasController.dispose();
    super.dispose();
  }*//*

}
*/
