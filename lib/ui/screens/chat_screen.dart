import 'package:flutter/material.dart';
import 'package:gerente_loja/ui/widgets/category_selector.dart';
import 'package:gerente_loja/ui/widgets/recent_chats.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(64, 75, 96, .9),
      body: Column(
        children: <Widget>[
          MenuSelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: Column(
                children: [
                 // Container(),
                  RecentChats(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
