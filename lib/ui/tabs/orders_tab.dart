import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/core/controllers/orders_controller.dart';
import 'package:gerente_loja/ui/widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _ordersController = BlocProvider.getBloc<OrdersController>();
    _ordersController.getOrders();

    return Scaffold(
      appBar: AppBar(
        title: Text('Compras da sua Loja'
          ,style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: StreamBuilder<List>(
            stream: _ordersController.outOrders,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                  ),
                );
              else if (snapshot.data.length == 0)
                return Center(
                  child: Text(
                    "Nenhum pedido encontrado!",
                    style: TextStyle(color: Colors.pinkAccent),
                  ),
                );

              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return OrderTile(snapshot.data[index]);
                  });
            }),
      ),
    );
  }
}
