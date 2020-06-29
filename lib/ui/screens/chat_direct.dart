import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/core/models/message.dart';
import 'package:gerente_loja/core/models/user.dart';
import 'package:gerente_loja/ui/widgets/message_composer.dart';
import 'package:intl/intl.dart';

class ChatDirect extends StatefulWidget {
  final User user;

  @override
  _ChatDirectState createState() => _ChatDirectState();

  ChatDirect({@required this.user});
}

class _ChatDirectState extends State<ChatDirect> {
  void _sendMessage({String text, File imgFile}) async {
    Map<String, dynamic> data = {};

    if (imgFile != null) {
      StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child('chat_images')
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(imgFile);

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      print(url);
      data['imgUrl'] = url;
    }
    if (text != null) data['text'] = text;

    Firestore.instance.collection('messages').add(data);
  }

  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
          : EdgeInsets.only(top: 8.0, bottom: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
          color: isMe ? Colors.yellow[100] : Color(0xFFFFEFEE),
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0))
              : BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('kk:mm').format(message.time),
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            message.text,
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: [
        msg,
        IconButton(
          icon: message.isliked
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
          iconSize: 30.0,
          color: message.isliked ? Colors.red : Colors.blueGrey,
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'widget.user.name',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          )
        ],
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection('messages').snapshots(),
                    builder: (context, snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          List <DocumentSnapshot> documents=snapshot.data.documents;

                          return ListView.builder(
                              reverse: true,
                              padding: EdgeInsets.only(top: 15.0),
                              itemCount: documents.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                final Message message = Message.fromDocument(documents[index]);
                                final bool isMe = message.sender.id == 'FWJkTs9Vg0bAZCpR5C2QZRXVTCs2';

                                return _buildMessage(message, isMe);
                              });
                      }

                    },

                  ),
                ),
              ),
            ),
            MessageComposer(_sendMessage)
          ],
        ),
      ),
    );
  }
}
