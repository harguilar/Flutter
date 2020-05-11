import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:gerente_loja/datas/quote_data.dart';
import 'package:gerente_loja/datas/reply_data.dart';
import 'package:gerente_loja/repository/data_repository.dart';


enum PartStatus { nova, usada }

class QuoteScreen extends StatefulWidget {

  final DocumentSnapshot snapshot;


  QuoteScreen(this.snapshot);

  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  PartStatus _status = PartStatus.nova;
  final DataRepository repository = DataRepository();
  TextEditingController _priceTextFiledController = TextEditingController();
  FirebaseUser firebaseUser;
  bool hideReplyFields= false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  


  bool _alreadyRepliedToQuote(List<Reply> list){

    if(list == null )
        return false;

   return list.firstWhere( (e)=> e.vendorId =='fWVNRbqtLJV619O9O4txhcCpyzE3', orElse:null)
       !=null  ? true :false ;

  }



  @override
  Widget build(BuildContext context) {


    QuoteData quote =QuoteData.fromDocument(widget.snapshot);

    hideReplyFields=_alreadyRepliedToQuote(quote.replies);


    return Scaffold(
      key:  _scaffoldKey,
        appBar: AppBar(
          title: Text('${ widget.snapshot.data['vehicle']} ',
            style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold),),
          centerTitle: true,

          backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        ),
        body: ListView(
          children: [
              AspectRatio(
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
          )
            ,
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Peça: ${ widget.snapshot.data['partName']}',
                    style:
                    TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                    maxLines: 3,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    widget.snapshot.data['vehicle'],
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                    maxLines: 3,
                  ),

                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Data: ${widget.snapshot.data['data']}',
                        style:
                            TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                        maxLines: 3,
                      ),
                      SizedBox(width: 8,),
                      hideReplyFields ? Text('Respondido',style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold),) : Container()

                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  hideReplyFields ? Container(child: Text('Já respondeu a esta Solicitação de Proforma !',
                    style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),
                    maxLines: 2,
                  ),

                  ) :
                  TextField(
                    controller: _priceTextFiledController,
                      decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Preço \$',
                  )),
                  SizedBox(
                    height: 15.0,
                  ),
                  !hideReplyFields ?  Row(
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
                  ],):Container(),
                  !hideReplyFields ? SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      onPressed: () {


                        quote.status='replied';

                        Reply reply =Reply(
                            vendorId: 'fWVNRbqtLJV619O9O4txhcCpyzE3'/*firebaseUser.uid*/,
                            vendorName: 'Samuel Jackson',
                            data: DateTime.now(),
                            brandNew: _status==PartStatus.nova ? true:false ,
                            price: double.parse(_priceTextFiledController.text));

                        quote.replies.add(reply);
                        repository.updateQuote(quote);


                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          elevation: 0.0,
                          duration: Duration(seconds: 5),
                          content: Text('Proforma Enviada com sucesso!Espere pela decisão do Cliente',
                          style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18.0),),
                        ));
                       // Navigator.pop(context);





                      },
                      child: Text(
                        'Enviar Preço',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      color: Colors.redAccent,
                      textColor: Colors.white,
                    ),
                  ): Container()
                ],
              ),
            )
          ],
        )


        );
  }
}
