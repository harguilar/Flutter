import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gerente_loja/core/models/order.dart';
import 'package:gerente_loja/core/providers/orders_provider.dart';




class OrdersController extends BlocBase{
  StreamController<List<Order>> _ordersController =
  StreamController<List<Order>>.broadcast();

  Stream<List<Order>> get outOrders => _ordersController.stream;
  bool _isDisposed = false;
  StreamSink<List<Order>> get inOrders => _ordersController.sink;
  OrdersProvider _orderProvider = OrdersProvider();
  List<Order> _ordersList =List();

  OrdersController() {
    _ordersController.add(_ordersList);
    //_controllerSaveProforma.stream.listen(_saveProformaData);
  }

  Future<void> getOrders() {
    if (_isDisposed) {
      return null;
    }
    return _orderProvider.getOrders().then(
            (dados) {
          if (dados != null) {
            _ordersList = dados;
            _ordersController.sink.add(dados);
          }
        }
    );
  }

  /*void dispose(){
    _ordersController.close();
    _ordersController.sink.close();
    //inOrders.close();
  }*/
}
