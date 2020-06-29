import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/core/models/message.dart';
import 'package:gerente_loja/ui/screens/chat_direct.dart';
import 'package:intl/intl.dart';

class RecentChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                    stream: Firestore.instance
                        .collection('messages')
                        .document()
                        .collection('roomMessages')
                        .snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          List<DocumentSnapshot> documents =
                              snapshot.data.documents;

                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                final Message chat =
                                Message.fromDocument(documents[index]);

                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ChatDirect(user: chat.sender))),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 5.0, bottom: 5.0, right: 20.0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    decoration: BoxDecoration(
                                        color: chat.unread
                                            ? Color(0xFFFFEFEE)
                                            : Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0),
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 35.0,
                                              backgroundImage: NetworkImage(
                                                /*chat.sender.imageUrl*/
                                                  'https://randomuser.me/api/portraits/men/80.jpg'),
                                            ),
                                            SizedBox(
                                              width: 12.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ' chat.sender.name',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.45,
                                                  child: Text(
                                                    chat.text,
                                                    style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                        FontWeight.w600),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              DateFormat('kk:mm')
                                                  .format(chat.time),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 6.0,
                                            ),
                                            chat.unread
                                                ? Container(
                                                width: 40.0,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        30.0)),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Novo',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ))
                                                : SizedBox.shrink()
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                      }
                    })),
          ),
        )
      ],
    );
  }
}
