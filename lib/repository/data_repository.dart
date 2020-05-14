import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerente_loja/datas/proforma_model.dart';
import 'package:gerente_loja/datas/reply_data.dart';



class DataRepository {
  final CollectionReference collection = Firestore.instance.collection('proformas');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addQuote(ProformaModel proformaModel) {
    return collection.add(proformaModel.toJson());
  }
  Future<DocumentReference> addQuoteReply(Reply reply) {
    return collection.add(reply.toJson());
  }

  updateQuote(ProformaModel proformaModel) async {
    await collection.document(proformaModel.userId).setData(proformaModel.toJson() ,merge: true);
  }

  addReply(Reply reply,ProformaModel proformaModel) async{
   // await collection.document(proformaModel.userId).collection('replies').document(reply.vendorId).setData(reply.toJson());
    await collection.document(proformaModel.userId).collection('replies').add(reply.toJson());

  }
}