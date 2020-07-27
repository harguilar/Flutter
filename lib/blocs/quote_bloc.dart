import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class QuoteBloc extends BlocBase {

  final _quotesController = BehaviorSubject<List>();

  Stream<List> get outQuotes => _quotesController.stream;

  Map<String, Map<String, dynamic>> _quotes = {};

  Firestore _firestore = Firestore.instance;

  QuoteBloc(){
    _addQuotesListener();
  }

  void onChangedSearch(String search){
    if(search.trim().isEmpty){
      _quotesController.add(_quotes.values.toList());
    } else {
      _quotesController.add(_filter(search.trim()));
    }
  }

  List<Map<String, dynamic>> _filter(String search){
    List<Map<String, dynamic>> filteredUsers = List.from(_quotes.values.toList());
    filteredUsers.retainWhere((user){
      return user["name"].toUpperCase().contains(search.toUpperCase());
    });
    return filteredUsers;
  }

  void _addQuotesListener(){
    _firestore.collection("quotes").snapshots().listen((snapshot){
      snapshot.documentChanges.forEach((change){

        String uid = change.document.documentID;

        switch(change.type){
          case DocumentChangeType.added:
            _quotes[uid] = change.document.data;
            _subscribeToOrders(uid);
            break;
          case DocumentChangeType.modified:
            _quotes[uid].addAll(change.document.data);
            _quotesController.add(_quotes.values.toList());
            break;
          case DocumentChangeType.removed:
            _quotes.remove(uid);
            _unsubscribeToOrders(uid);
            _quotesController.add(_quotes.values.toList());
            break;
        }

      });
    });
  }

  void _subscribeToOrders(String uid){
    _quotes[uid]["subscription"] = _firestore.collection("quotes").document(uid)
        .collection("orders").snapshots().listen((orders) async {

      int numOrders = orders.documents.length;

      double money = 0.0;

      for(DocumentSnapshot d in orders.documents){
        DocumentSnapshot order = await _firestore
            .collection("orders").document(d.documentID).get();

        if(order.data == null) continue;

        money += order.data["totalPrice"];
      }

      _quotes[uid].addAll(
          {"money": money, "orders": numOrders}
      );

      _quotesController.add(_quotes.values.toList());
    });
  }

  Map<String, dynamic> getUser(String uid){
    return _quotes[uid];
  }

  void _unsubscribeToOrders(String uid){
    _quotes[uid]["subscription"].cancel();
  }

  @override
  void dispose() {
    _quotesController.close();
    super.dispose();
  }

}