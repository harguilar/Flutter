import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/core/controllers/orders_controller.dart';
import 'package:gerente_loja/core/models/order.dart';
import 'package:gerente_loja/helpers/const_global.dart';
import 'package:gerente_loja/ui/tiles/order_tile.dart';
import 'package:gerente_loja/ui/widgets/custom_app_bar.dart';

class OrdersTab extends StatelessWidget {
  bool isVendor;




  @override
  Widget build(BuildContext context) {

    final ordersController = BlocProvider.getBloc<OrdersController>();
    ordersController.getOrders();





    return Scaffold(
      appBar: appBar(context, 'Estado das  compras'),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: StreamBuilder<DataConnectionStatus>(
          stream: DataConnectionChecker().onStatusChange,
          builder: (context, snap) {
            if (snap.data == DataConnectionStatus.disconnected) {
              return Center(
                child: Text(
                  "Sem Internet!Ligue a sua internet",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              );
            } else
              return StreamBuilder<List<Order>>(
                  stream: ordersController.outOrders,
                  builder: (context, snapst){

                    if (!snapst.hasData)
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation(Colors.red),
                        ),
                      );
                    else if (snapst.data.length == 0)
                      return Center(
                        child: Text(
                          isVendor
                              ? 'Sua loja ainda não tem vendas'
                              : "Ainda não realizou compras.Selecione uma peça das proformas recebidas!",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0),
                        ),
                      );

                    return ListView.builder(
                        itemCount: snapst.data.length,
                        itemBuilder: (context, index) {
                          //final newOrder = orderListPerUserRole(snapshot.data[index]);
                          return OrderTile(snapst.data[index]);
                        });
                  });
          },
        ),
      ),
    );
    /*

  Order orderListPerUserRole(Order order){

         Order newOrder;

    if(isVendor) newLiST = orderList.where((element) => element.vendorId==ConstGlobal.user.uid).toList();
    else  newLiST = orderList.where((element) => element.buyerId==ConstGlobal.user.uid).toList();
    return newOrder;


  }
      */
  }
}
