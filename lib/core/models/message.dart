import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerente_loja/core/models/user.dart';

class Message {
  User sender;
  DateTime time;
  String text;
  bool isliked;
  bool unread;

  Message({this.sender, this.time, this.text, this.isliked, this.unread});

  Message.fromDocument(DocumentSnapshot documentSnapshot) {
    sender = documentSnapshot.data['sender'];
    time = documentSnapshot.data['time'];
    text = documentSnapshot.data['text'];
    isliked = documentSnapshot.data['isliked'];
    unread = documentSnapshot.data['unread'];
  }
}
