import 'package:flutter/material.dart';
import 'package:gerente_loja/core/models/order.dart';
import 'package:intl/intl.dart';


class OrderTile extends StatelessWidget {
  final Order _order;

  OrderTile(this._order);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Container(
                      width: 65.0,
                      child: Image.network(
                        _order.imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Carro: ${_order.vehicle}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Data do pedido: ${DateFormat("dd-MM-yyyy").format(_order.date)}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Cliente: ${_order.buyerName}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Peça: ${_order.title}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Quantidade: ${_order.quantity}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Preço: ${_order.price}",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                        ),

                        Text(
                          "Total: AOA\$ ${_order.totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: 6.0,
                ),
                Text(
                  "Estado do Pedido:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildCircle("1", "Pendente", _order.status, 1),
                    Expanded(

                      child: Container(
                        height: 1.0,
                        width: 25.0,
                        color: Colors.grey[500],
                      ),
                    ),
                    _buildCircle("2", "Preparando", _order.status, 2),
                    Expanded(

                      child: Container(
                        height: 1.0,
                        width: 25.0,
                        color: Colors.grey[500],
                      ),
                    ),
                    _buildCircle("3", "Transporte", _order.status, 3),
                    Expanded(

                      child: Container(
                        height: 1.0,
                        width: 25.0,
                        color: Colors.grey[500],
                      ),
                    ),
                    _buildCircle("4", "Entregue", _order.status, 4),
                  ],
                )
              ],
            )));
  }



  Widget _buildCircle(
      String title, String subtitle, int status, int thisStatus) {
    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(
        Icons.check,
        color: Colors.white,
      );
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle)
      ],
    );
  }

}