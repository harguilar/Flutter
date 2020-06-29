import 'dart:async';

import 'package:gerente_loja/core/models/order.dart';
import 'package:gerente_loja/core/providers/orders_provider.dart';



class ChatController{



  StreamController<List<Order>> _ordersController =StreamController<List<Order>>.broadcast();

  Stream<List<Order>> get outOrders => _ordersController.stream;

  StreamSink<List<Order>> get inOrders => _ordersController.sink;
  List<Order> _ordersList=List();
  OrdersProvider _orderProvider = OrdersProvider();


  Future<List<Order>> getOrders() {

/*    _ordersList = _orderProvider.getUserOrders();
    _ordersController.sink.add(_ordersList);
    return _ordersList;*/

    return _orderProvider.getUserOrders().then(
            (dados) {
          print(dados);
          if(dados != null){
            _ordersList = dados;
            _ordersController.sink.add(dados);
          }

        }
    );
  }

}