import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerente_loja/core/datamodels/reply_data.dart';
import 'package:gerente_loja/core/services/authentication_service.dart';
import 'package:gerente_loja/locator.dart';


class ProformaData{
  String id;
  String userId = '';
  String userVehiclId;
  DateTime date;
  int status;
  String peca;
 // var imgUrl;
  String vinNumber;
  String make;
  String model;
  String trim;
  String year;
  var imageFileName;


 // Proforma obj;
  ProformaData({
    @required this.make,
    @required this.model,
    @required this.peca,
    @required this.vinNumber,
    @required this.year,
    @required this.trim
   // @required this.imgUrl,
  });

  get userID => userId;

  //Setters.
  void set userID (var useRID){
     userId = useRID;
  }

  ProformaData.fromDocument(DocumentSnapshot documentSnapshot){
    id=documentSnapshot.documentID;
    userId=documentSnapshot.documentID;
    date= documentSnapshot.data['date'].toDate();
    peca= documentSnapshot.data['peca'];
    status= documentSnapshot.data['status'];
    //imgUrl = documentSnapshot.data['imgUrl'];
    year= documentSnapshot.data['year'];
    make= documentSnapshot.data['make'];
    model = documentSnapshot.data['model'];
    trim = documentSnapshot.data['trim'];

    Firestore.instance.collection('proformas').document(documentSnapshot.documentID)
        .collection('replies').snapshots().listen( _convertReplies );
  }

  List<Reply> _convertReplies(QuerySnapshot snapshot) {
    var docs = snapshot.documents;
    var replies=List<Reply>();
    for(var doc in docs ){
      replies.add( Reply.fromDocument(doc));
    }
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

/*  factory Proforma.fromJson(Map<String, dynamic> json) => Proforma(
    _id: json["id"],
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
  );*/

/*
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
    "id" : id
  };
  */

  }

