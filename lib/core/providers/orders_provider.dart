import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerente_loja/core/models/order.dart';
import 'package:gerente_loja/helpers/const_global.dart';


class OrdersProvider {
  FirebaseUser user;

  OrdersProvider() {
    ConstGlobal.getCurrentUser().then((value) => user = value);
  }

  var refUsers = Firestore.instance.collection('users');
  var refOrders = Firestore.instance.collection('orders');

  List<Order> _ordersList = List();
  List<String> _orderIds = List();

  Future<List<Order>> getUserOrders() async {
    bool connectionState = await DataConnectionChecker().hasConnection;

    if (connectionState) {
      await refOrders.where('vendorId',isEqualTo:user.uid )
          .getDocuments()
          .then((querySnap) => {
        _ordersList = querySnap.documents.map((item) {
          return Order(
              id: item.data['id'],
              price: item.data['price'].toDouble(),
              status: item.data['status'],
              title: item.data['title'],
              quantity: item.data['quantity'],
              date: item.data['date'].toDate(),
              totalPrice: item.data['totalPrice'].toDouble(),
              vendorName :item.data['vendorName'],
              buyerName:item.data['buyerName'],
            imgUrl: item.data['imgUrl'],
            vehicle: item.data['vehicle']
          );

        }).toList()
      });

      return _ordersList;
    } else {
      return List();
    }

    /*  refUsers.document(userId).collection('orders').getDocuments().then((snapshot)=>{
    snapshot.documents.map((documentSnapshot ) =>_orderIds.add(documentSnapshot.documentID)
    )
    }) ;
    _orderIds.forEach((element) {
      refOrders.document(element).get().then((snapshot) => {
        _ordersList.add(Order.fromDocument(snapshot) )
      });
    });
    return _ordersList;*/
  }
}