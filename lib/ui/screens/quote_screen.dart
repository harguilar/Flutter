import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/helpers/const_global.dart';
import 'package:gerente_loja/models/proforma.dart';
import 'package:gerente_loja/models/reply_data.dart';
import 'package:gerente_loja/repository/repository.dart';
import 'package:intl/intl.dart';

enum PartStatus { nova, usada }

class QuoteScreen extends StatefulWidget {
  final DocumentSnapshot snapshot;

  QuoteScreen(this.snapshot);

  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  PartStatus _status = PartStatus.nova;
  final Repository repository = Repository();
  TextEditingController _priceTextFiledController = TextEditingController();
  FirebaseUser firebaseUser;
  bool hideReplyFields = false;
  FirebaseUser vendor;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> dt = Map<String, dynamic>();

  void iniState() {
    super.initState();
    ConstGlobal.getCurrentUser().then((value) => vendor = value);
    _alreadyRepliedToQuote(widget.snapshot)
        .then((value) => hideReplyFields = value);
  }

//Check if this vendor has already replied to this quotation

  Future<bool> _alreadyRepliedToQuote(DocumentSnapshot documentSnapshot) async {
    try {
      return await Firestore.instance
          .collection('proformas')
          .document(documentSnapshot.documentID)
          .collection('replies')
          .document('oezmYolpDFXiyRXZvzPvfbmDAah1')
          .get()
          .then((value) => value.exists);
    } catch (err) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    ConstGlobal.getCurrentUser().then((value) => vendor = value);

    Proforma proformaModel = Proforma.fromDocument(widget.snapshot);
    dt = widget.snapshot.data;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            '${dt['make']} ' +
                '${dt['model']} ' +
                '${dt['year']}' +
                ' ' +
                '${dt['trim']}',
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        ),
        body: ListView(
          children: [
            Image.network(dt['imgUrl'])
            /* AspectRatio(
            aspectRatio: 0.9,
            child:  Carousel(
              images: widget.snapshot.data['images'].map( (url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0 ,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: Theme.of(context).primaryColor,
              autoplay: false,
            ),
          )*/
            ,
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Peça: ${dt['peca']}',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    dt['make'] + ' ' + dt['model'] + ' ' + dt['trim'],
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    hideReplyFields
                        ? 'Você enviou uma proforma aos: ${DateFormat('dd-MM-yyyy').format(dt['date'].toDate())}'
                        : 'Data enviada: ${DateFormat('dd-MM-yyyy').format(dt['date'].toDate())}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  hideReplyFields
                      ? Container(
                          child: Text(
                            'Você Já respondeu a esta Solicitação de Proforma !',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            maxLines: 2,
                          ),
                        )
                      : TextField(
                          controller: _priceTextFiledController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Preço \$',
                          )),
                  SizedBox(
                    height: 15.0,
                  ),
                  !hideReplyFields
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Nova'),
                            Radio(
                                value: PartStatus.nova,
                                groupValue: _status,
                                onChanged: (PartStatus value) {
                                  setState(() {
                                    _status = value;
                                  });
                                }),
                            Text('Segunda Mão'),
                            Radio(
                                value: PartStatus.usada,
                                groupValue: _status,
                                onChanged: (PartStatus value) {
                                  setState(() {
                                    _status = value;
                                  });
                                })
                          ],
                        )
                      : Container(),
                  !hideReplyFields
                      ? SizedBox(
                          height: 44.0,
                          child: RaisedButton(
                            onPressed: () {
                              proformaModel.status = 2;

                              Reply reply = Reply(
                                  vendorId: vendor.uid,
                                  vendorName: vendor.displayName,
                                  date: DateTime.now(),
                                  brandNew:
                                      _status == PartStatus.nova ? true : false,
                                  price: double.parse(
                                      _priceTextFiledController.text));

                              repository.updateQuote(proformaModel);
                              repository.addReply(reply, proformaModel);

                              setState(() {});

                              Flushbar(
                                title: "PROFORMA ENVIADO COM SUCESSO ",
                                message:
                                    "Proforma Enviada com sucesso!Espere pela decisão do Cliente!!",
                                duration: Duration(seconds: 6),
                                flushbarStyle: FlushbarStyle.FLOATING,
                                flushbarPosition: FlushbarPosition.BOTTOM,
                                reverseAnimationCurve: Curves.decelerate,
                                forwardAnimationCurve: Curves.elasticOut,
                              )..show(context);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Enviar Preço',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            color: Colors.redAccent,
                            textColor: Colors.white,
                          ),
                        )
                      : Container()
                ],
              ),
            )
          ],
        ));
  }
}
