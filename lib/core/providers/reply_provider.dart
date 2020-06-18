
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:gerente_loja/core/models/reply_data.dart';


class ReplyProvider{

  var ref =Firestore.instance.collection("proformas");



  Future<List<Reply>> getRepliesForProforma(String proformaId) async {
    bool connectionState = await DataConnectionChecker().hasConnection;

    List<Reply> _replyList;

    if (connectionState) {
      var result = await ref.document(proformaId).collection('replies').getDocuments();

      _replyList=result.documents.map((data){
        return Reply.fromDocument(data);

      }).toList();

      return _replyList;
    } else {
      return null;
    }
  }



}



