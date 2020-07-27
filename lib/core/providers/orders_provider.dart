import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:gerente_loja/core/models/order.dart';

class OrdersProvider {

  var refOrders = Firestore.instance.collection('orders');
  List<Order> _ordersList = List();

  Future<List<Order>> getOrders() async {
    bool connectionState = await DataConnectionChecker().hasConnection;

    if (connectionState) {
      await refOrders.getDocuments().then((querySnap) {

        _ordersList = querySnap.documents.map((item) {
          return Order(
              id: item.data['id'],
              price: item.data['price'].toDouble(),
              status: item.data['status'],
              title: item.data['title'],
              quantity: item.data['quantity'],
              date: item.data['date'].toDate(),
              totalPrice: item.data['totalPrice'].toDouble(),
              vendorName: item.data['vendorName'],
              vendorId: item.data['vendorId'],
              buyerId: item.data['buyerId'],
              buyerName: item.data['buyerName'],
              vehicle: item.data['vehicle']
          );

        }).toList();
      });

      return _ordersList;
    } else {
      return List();
    }
  }
}
