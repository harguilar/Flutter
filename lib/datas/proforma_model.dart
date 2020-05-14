import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerente_loja/datas/reply_data.dart';


class ProformaModel{

  String userId;
  int ano;
  DateTime data;
  String marca;
  String modelo;
  String motor;
  String peca;
  String imgUrl;
  int estado;




  ProformaModel(){


  }

  ProformaModel.fromDocument(DocumentSnapshot documentSnapshot){
    userId=documentSnapshot.documentID;
    data= documentSnapshot.data['data'].toDate();
    peca= documentSnapshot.data['peca'];
    estado= documentSnapshot.data['estado'];
    imgUrl = documentSnapshot.data['imgUrl'];
    ano= documentSnapshot.data['ano'];
    marca= documentSnapshot.data['marca'];
    modelo = documentSnapshot.data['modelo'];
    motor = documentSnapshot.data['motor'];

    Firestore.instance.collection('proformas').document(documentSnapshot.documentID)
        .collection('replies').snapshots().listen( _convertReplies );
  }

  Map<String, dynamic> toJson() => _QuoteToJson(this);


  Map<String, dynamic> _QuoteToJson(ProformaModel instance) => <String, dynamic> {
    'userId': instance.userId,
    'data': instance.data,
    'peca': instance.peca,
    'imgUrl': instance.imgUrl,
    'estado': instance.estado,
    'ano': instance.ano,
    'marca': instance.marca,
    'modelo': instance.modelo,
    'motor': instance.motor,
  };

  List<Reply> _convertReplies(QuerySnapshot snapshot) {

        var docs = snapshot.documents;
        var replies=List<Reply>();

        for(var doc in docs ){

          replies.add( Reply.fromDocument(doc));


        }

/*    if (repliesMap == null) {
      return null;
    }
    List<Reply> replies =  List<Reply>();
    repliesMap.forEach((value) {
      replies.add(Reply.replyFromJson(value));
    });*/
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