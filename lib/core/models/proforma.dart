import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerente_loja/core/models/reply_data.dart';



List<Proforma> listProformas(String str) => List<Proforma>.from(json.decode(str).map((x) => Proforma.fromJson(x)));

/*
enum ProformaEstado{
  semCotacao,comCotacao,arquivado
}
*/

class Proforma {

  String id;
  String userId;
  String userVehiclId;
  DateTime date;
  int status;
  String peca;
  String imgUrl;
  String vinNumber;
  String make;
  String model;
  String trim;
  int year;
  String userName;





  Proforma({
    this.id,
    this.userVehiclId,
    this.userId,
    this.year,
    this.date,
    this.status,
    this.peca,
    this.imgUrl,
    this.vinNumber,
    this.make,
    this.model,
    this.trim,
    this.userName
  });


  Proforma.fromDocument(DocumentSnapshot documentSnapshot){
    id=documentSnapshot.documentID;
    userId=documentSnapshot.documentID;
    date= documentSnapshot.data['date'].toDate();
    peca= documentSnapshot.data['peca'];
    status= documentSnapshot.data['status'];
    imgUrl = documentSnapshot.data['imgUrl'];
    year= documentSnapshot.data['year'];
    make= documentSnapshot.data['make'];
    model = documentSnapshot.data['model'];
    trim = documentSnapshot.data['trim'];
    userName=documentSnapshot.data['userName'];

    Firestore.instance.collection('proformas').document(documentSnapshot.documentID)
        .collection('replies').snapshots().listen( _convertReplies );
  }

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



  factory Proforma.fromJson(Map<String, dynamic> json) => Proforma(
    id: json["id"],
    userVehiclId: json["userVehiclId"],
    date: json["date"],
    status: json["status"],
    imgUrl: json["imgUrl"],
    year: json["year"],
    peca: json["peca"],
    vinNumber: json["vinNumber"],
    make: json["make"],
    model: json["model"],
    trim: json["trim"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "userId":userId,
    "year": year,
    "peca": peca,
    "imgUrl": imgUrl,
    "status":status,
    "date":date,
    "vinNumber":vinNumber,
    "make":make,
    "model":model,
    "trim":trim,
    "id" : id,
    "userName":userName
  };

}
