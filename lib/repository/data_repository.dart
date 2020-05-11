import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerente_loja/datas/quote_data.dart';
import 'package:gerente_loja/datas/reply_data.dart';



class DataRepository {
  final CollectionReference collection = Firestore.instance.collection('quotes');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addQuote(QuoteData quote) {
    return collection.add(quote.toJson());
  }
  Future<DocumentReference> addQuoteReply(Reply reply) {
    return collection.add(reply.toJson());
  }

  updateQuote(QuoteData quote) async {
    await collection.document(quote.id).setData(quote.toJson() ,merge: true);
  }
}