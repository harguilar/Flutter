/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/core/datamodels/proforma_data.dart';
import 'package:gerente_loja/core/datamodels/vehicle_user.dart';
import 'package:gerente_loja/helpers/const_global.dart';

class CustomRaisedButton extends StatefulWidget {
  bool canSave;
  TextEditingController vinController;
  bool seeImg;
  String txtPeca;
  List<VehicleUser> myVehicles;

  CustomRaisedButton({@required this.canSave,@required this.vinController
    , @required this.txtPeca,@required this.seeImg,@required this.myVehicles});



  @override
  _CustomRaisedButtonState createState() => _CustomRaisedButtonState();
}

class _CustomRaisedButtonState extends State<CustomRaisedButton> {
  bool isLoading= false;
  String _selectedValue;
  VehicleUser selectedVehicle;
  Proforma proformaModel;
  String userId;


  @override
  Widget build(BuildContext context) {

    userId = ConstGlobal.user.uid;
    return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: Colors.red,
        child: Text(
          "ENVIAR PEDIDO",
          style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        onPressed: widget.canSave ?() async {
          setState(() {
            isLoading = true;
            widget.canSave= false;
          });

          if (_selectedValue != null) {
            selectedVehicle =
                widget.myVehicles.firstWhere((element) =>
                element.id == _selectedValue);

            if (ConstGlobal.img != null) {
              StorageUploadTask task =
              FirebaseStorage.instance
                  .ref()
                  .child(widget.vinController.text +
                  DateTime.now()
                      .millisecondsSinceEpoch
                      .toString())
                  .putFile(ConstGlobal.img);

              await task.onComplete
                  .then((value) async {
                await value.ref
                    .getDownloadURL()
                    .then((url) async {
                  proformaModel = Proforma(
                      id: userId,
                      make: selectedVehicle.make,
                      model: selectedVehicle.model,
                      trim: selectedVehicle.trim,
                      year: selectedVehicle.year,
                      status: 1,
                      userVehiclId: _selectedValue,
                      peca: widget.txtPeca,
                      date: DateTime.now(),
                      userId: userId,
                      imgUrl: url.toString());
                });
              });
            } else {
              */
/*proformaModel = Proforma(
                  id: userId,
                  make: selectedVehicle.make,
                  model: selectedVehicle.model,
                  trim: selectedVehicle.trim,
                  year: selectedVehicle.year,
                  status: 1,
                  userVehiclId: _selectedValue,
                  peca: widget.txtPeca,
                  date: DateTime.now(),
                  userId: userId,
                  imgUrl: "null");*//*

            }
           */
/* await Firestore.instance
                .collection("proformas")
                .document()
                .setData(proformaModel.toJson())
                .then((dados) {
              setState(() {
                isLoading = false;
                //_txtPeca.clear();
                widget.vinController.clear();
                //seeImg = false;*//*

             // });


            });
          } else {
            if (ConstGlobal.img == null) {
              proformaModel = Proforma(
                  id: userId,
                  status: 1,
                  userVehiclId: "null",
                  vinNumber: widget.vinController.text,
                  peca: widget.txtPeca,
                  date: DateTime.now(),
                  userId: userId,
                  imgUrl: "");

              await Firestore.instance
                  .collection("proformas")
                  .document()
                  .setData(proformaModel.toJson())
                  .then((dados) {
                setState(() {
                  isLoading = false;
                  //_txtPeca.clear();
                  widget.vinController.clear();
                  widget.seeImg = false;
                });
              });
            } else {
              StorageUploadTask task =
              FirebaseStorage.instance
                  .ref()
                  .child(widget.vinController.text +
                  DateTime.now()
                      .millisecondsSinceEpoch
                      .toString())
                  .putFile(ConstGlobal.img);

              await task.onComplete
                  .then((value) async {
                await value.ref
                    .getDownloadURL()
                    .then((url) async {
                  proformaModel = Proforma(
                      id: userId,
                      status: 1,
                      userVehiclId: _selectedValue,
                      peca: widget.txtPeca,
                      date: DateTime.now(),
                      userId: userId,
                      imgUrl: url.toString(),
                      vinNumber:
                      widget.vinController.text);

                  await Firestore.instance
                      .collection("proformas")
                      .document()
                      .setData(
                      proformaModel.toJson())
                      .then((dados) {
                    setState(() {
                      isLoading = false;
                      //_txtPeca.clear();
                      widget.vinController.clear();
                      widget.seeImg = false;
                    });
                  });
                });
              });
            }
          }

          Flushbar(
            title:
            "PEDIDO DE PROFORMA ENVIADO COM SUCESSO ",
            message:
            "Aguarde pela resposta das lojas!Acompanhe o estado da proforma na aba Proformas",
            duration: Duration(seconds: 6),
            flushbarStyle: FlushbarStyle.FLOATING,
            flushbarPosition:
            FlushbarPosition.BOTTOM,
            reverseAnimationCurve:
            Curves.decelerate,
            forwardAnimationCurve:
            Curves.elasticOut,
          )..show(context);
        }:null
          );
  }
}
*/
