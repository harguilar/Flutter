import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/formatNumbers/format_Numbers.dart';
import 'package:jeilaonlinestore/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class CartPrice extends StatelessWidget {
  final  VoidCallback buy;
  CartPrice(this.buy);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        //The Price will Vary depending on the Product you Have with the Cart
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model){

            //Get The Price of The Product
            double price = model.getProductPrice();

            //Get The Amount formated.
            FormatNumber formatCurrency = FormatNumber();

            //Format The Price Accordingly.
            FlutterMoneyFormatter priceAmount = formatCurrency.format(price);

            //Get Tax Value.
            double tax = model.getTax();

            //Format Your Currency For Delivery
            FlutterMoneyFormatter taxAmount = formatCurrency.format(tax);

            //Get Delivery
            double delivery = model.getDelivery();

            //Format Your Currency For Delivery
            FlutterMoneyFormatter deliveryAmount = formatCurrency.format(delivery);

            //Get total
            double total = model.getTotal();

            //Format Your Currency For Delivery
            FlutterMoneyFormatter totalAmount = formatCurrency.format(total);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Resumo do Pedido',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),

                SizedBox (height: 12.0,),
                Row (
                  //Give Space so that the Subtotal and Price Stay in Both Ends.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Subtotal'),
                    Text('${priceAmount.output.symbolOnLeft}')
                  ],
                ),
                Divider(),
                Row (
                  //Give Space so that the Subtotal and Price Stay in Both Ends.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Imposto'),
                    Text('${taxAmount.output.symbolOnLeft}')
                  ],
                ),
                Divider(),
                Row (
                  //Give Space so that the Subtotal and Price Stay in Both Ends.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Entrega'),
                    Text('${deliveryAmount.output.symbolOnLeft}')
                  ],
                ),
                SizedBox(height: 12.0,),
                Divider(),
                Row (
                  //Give Space so that the Subtotal and Price Stay in Both Ends.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total',
                      style: TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.black,
                      ),
                    ),
                    Text('${totalAmount.output.symbolOnLeft}',
                      style: TextStyle(fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12.0,),
                RaisedButton (
                  onPressed: buy,
                  child: Text('Finalizar o Pedido',),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                ),

              ],
            );

          },
        ),
      ),
    );
  }
}
