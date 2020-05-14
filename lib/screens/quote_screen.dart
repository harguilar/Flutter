import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:gerente_loja/datas/proforma_model.dart';
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
  Map<String ,dynamic> dt =Map<String, dynamic>();
  


 Future<void> _alreadyRepliedToQuote  (DocumentSnapshot documentSnapshot)async{

   QuerySnapshot _docList;

     _docList = await Firestore.instance.collection('proformas').document(documentSnapshot.documentID)
        .collection('replies').where("vendorId", isEqualTo: "fWVNRbqtLJV619O9O4txhcCpyzE3").getDocuments();

   hideReplyFields =(_docList.documents.length>1) ;

        
  }



  @override
  Widget build(BuildContext context){


    ProformaModel proformaModel =ProformaModel.fromDocument(widget.snapshot);
    dt=widget.snapshot.data;


      _alreadyRepliedToQuote(widget.snapshot);
    
    
    for(int i=1;i<15;i++)
    print(hideReplyFields);


    return Scaffold(
      key:  _scaffoldKey,
        appBar: AppBar(
          title: Text('${ dt['marca']} ' +'${dt['modelo'] } '+ '${dt['ano'] }' +'${dt['motor']}',
            style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold),),
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
                    'Peça: ${ dt['peca']}',
                    style:
                    TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                    maxLines: 3,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    dt['marca']+' '+dt['modelo']+' '+dt['motor'],
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
                        'Data: 08/05/2020',
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


                        proformaModel.estado=2;

                        Reply reply =Reply(
                            vendorId: 'fWVNRbqtLJV619O9O4txhcCpyzE3'/*firebaseUser.uid*/,
                            vendorName: 'Samuel Jackson',
                            data: DateTime.now(),
                            brandNew: _status==PartStatus.nova ? true:false ,
                            price: double.parse(_priceTextFiledController.text)
                        );


                        repository.updateQuote(proformaModel);
                        repository.addReply(reply, proformaModel);


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
