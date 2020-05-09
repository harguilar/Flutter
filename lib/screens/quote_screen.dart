import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';


enum PartStatus { nova, usada }

class QuoteScreen extends StatefulWidget {

  final DocumentSnapshot snapshot;


  QuoteScreen(this.snapshot);

  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  PartStatus _status = PartStatus.nova;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('${ widget.snapshot.data['vehicle']} '),
          centerTitle: true,
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
                    widget.snapshot.data['vehicle'],
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    'Cliente: ${widget.snapshot.data['buyer']}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextField(
                      decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Preço \$',
                  )),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
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
                  ],),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        'Enviar Preço',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      color: Colors.redAccent,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        )


        );
  }
}
