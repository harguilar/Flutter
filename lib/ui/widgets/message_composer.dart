import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessageComposer extends StatefulWidget {
  final Function({String text, File imgFile}) sendMessage;

  MessageComposer(this.sendMessage);

  @override
  _MessageComposerState createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  bool isComposing = false;

  final TextEditingController _controller = TextEditingController();
  void _reset() {
    _controller.clear();
    setState(() {
      isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.photo_camera),
            iconSize: 25.0,
            color: Colors.red,
            onPressed: () async {
              final File imgFile =
                  await ImagePicker.pickImage(source: ImageSource.camera);
              if (imgFile == null) return;
              widget.sendMessage(imgFile: imgFile);
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (text) {
                setState(() {
                  isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text: text);
                _reset();
              },
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration.collapsed(
                hintText: 'Envie uma mensagem...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Colors.red,
            onPressed: isComposing
                ? () {
                    widget.sendMessage(text: _controller.text);
                    _reset();
                  }
                : null,
          )
        ],
      ),
    );
  }
}
