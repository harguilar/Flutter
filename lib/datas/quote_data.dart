import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerente_loja/datas/reply_data.dart';


class QuoteData{

  String id;
  String buyer;
  String data;
  String partName;
  String vehicle;
  String status;
  List images;
  List <Reply> replies = List<Reply>();
  DocumentReference reference;

  QuoteData(){}

  QuoteData.fromDocument(DocumentSnapshot documentSnapshot){
    id=documentSnapshot.documentID;
    data= documentSnapshot.data['data'];
    partName= documentSnapshot.data['partName'];
    status= documentSnapshot.data['status'];
    images = documentSnapshot.data['images'];
    replies = _convertReplies(documentSnapshot.data['replies']) ;
  }

  Map<String, dynamic> toJson() => _QuoteToJson(this);


  Map<String, dynamic> _QuoteToJson(QuoteData instance) => <String, dynamic> {
    /*'buyer': instance.buyer,*/
    'data': instance.data,
    'partName': instance.partName,
    /*'vehicle': instance.vehicle,*/
    'status': instance.status,
    'replies': _repliesList(instance.replies),
  };

  List<Reply> _convertReplies(List repliesMap) {
    if (repliesMap == null) {
      return null;
    }
    List<Reply> replies =  List<Reply>();
    repliesMap.forEach((value) {
      replies.add(Reply.replyFromJson(value));
    });
    return replies;
  }



  List<Map<String, dynamic>> _repliesList(List<Reply> replies) {
    if (replies == null) {
      return null;
    }
    List<Map<String, dynamic>> replyMap =List<Map<String, dynamic>>();
    replies.forEach((reply) {
      replyMap.add(reply.toJson());
    });
    return replyMap;
  }


}