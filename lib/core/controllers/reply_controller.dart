

import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gerente_loja/core/models/reply_data.dart';
import 'package:gerente_loja/core/providers/reply_provider.dart';



class ReplyController extends BlocBase{
  ReplyProvider _replyProvider = ReplyProvider();
  List<Reply> _replies=List();


  StreamController<List<Reply>> _replyController = StreamController<List<Reply>>.broadcast();
  Stream<List<Reply>> get outReplies => _replyController.stream;

  StreamSink<List<Reply>> get inReplies => _replyController.sink;


  Future<List<Reply>> getReplies(String proformaID) {

    return _replyProvider.getRepliesForProforma(proformaID).then(
            (dados) {
          // ignore: missing_return
          if(dados != null) _replies = dados;
          _replyController.sink.add(dados);
        }
    );
  }



  @override
  void dispose(){
    _replyController.close();
    super.dispose();
  }



}