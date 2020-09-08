import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gerente_loja/core/datamodels/proforma_data.dart';
import 'package:gerente_loja/core/viewmodels/proformaViewModel.dart';
import 'package:gerente_loja/locator.dart';
import 'package:gerente_loja/ui/widgets/images_field.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:stacked/stacked.dart';
import 'package:auto_route/auto_route.dart';
import 'package:gerente_loja/routes/router.gr.dart';
import 'package:path/path.dart';

import 'loginPage.dart';
class ProformaScreen extends StatefulWidget {
  //const ProformaScreen();
  @override
  _ProformaScreenState createState() => _ProformaScreenState();
}
class _ProformaScreenState extends State<ProformaScreen> {

  String marca = '';
  String file;
  String url;
  ImagesField list;


  final _pecaController    = TextEditingController();
  final _marcaController   = TextEditingController();
  final _modelController   = TextEditingController();
  final _chassisController = TextEditingController();
  final _yearController  = TextEditingController();
  final _trimController  = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _buildPeca() {
    return TextFormField(
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
      controller: _pecaController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.brown[500],
          ),
        ),
        labelText: 'Nome da Peça',
        hintText: 'Exmplo: ' + 'Pistões',
        icon: Icon(
          FontAwesomeIcons.tools,
          color: Colors.brown[500],
        ),
      ),
      //Open The Virtual KeyBoard on Phone
      keyboardType: TextInputType.text,
      validator: (String val) {
        if (val.isEmpty){
          return 'Inserir O nome da peça';
        }
      },
      autofocus: true,
    );
  }
  _buildChassis() {
    return TextFormField(
      maxLength: 17,
      maxLengthEnforced: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
      controller: _chassisController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.brown[500],
          ),
        ),
        labelText: 'Número do Chassis',
        hintText:  'Número do Chassis',

        icon: Icon(
          FontAwesomeIcons.idCard,
          color: Colors.brown[500],
        ),
      ),
      //Open The Virtual KeyBoard on Phone
      keyboardType: TextInputType.text,
      validator: (String val) {

        if (val.isNotEmpty && val.length != 9) {
          return "O número do chassis deve ser igual 9 carateres";
        }
        else if (val.isEmpty ){
          return ('Insir O número do chassis');
        }
      },
      autofocus: true,
    );
  }
  _buildModel(){
   return TextFormField(
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
      controller: _modelController,
      decoration: InputDecoration(
        // fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.brown[500],
          ),
        ),
        labelText: 'Modelo do Carro',
        //hintText: 'Exmplo: ' + 'Land Cruiser',
        //Disable The text Box
        icon: Icon(
          FontAwesomeIcons.car,
          color: Colors.brown[500],
        ),
      ),
      //Open The Virtual KeyBoard on Phone
      keyboardType: TextInputType.text,
      validator: (String val) {
        if (val.isEmpty){
          return "Por Favor, Escreva o Peça tipo Deseja ";
        }
      },
      autofocus: true,
    );
  }
  _buildYear(){
    return TextFormField(
      maxLength: 4,
      maxLengthEnforced: true,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
      controller: _yearController,
      decoration: InputDecoration(
        // fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.brown[500],
          ),
        ),
        labelText: 'Ano do Carro',
        //hintText: 'Exmplo: ' + 'Land Cruiser',
        //Disable The text Box
        icon: Icon(
          FontAwesomeIcons.calendar,
          color: Colors.brown[500],
        ),
      ),
      //Open The Virtual KeyBoard on Phone
      keyboardType: TextInputType.phone,
      validator: (String val) {
        if (val.isEmpty){
          return "Por Favor, Escreva o Peça tipo Deseja ";
        }
      },
      autofocus: true,
    );
  }
  _buildTrim(){
    return TextFormField(
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
      controller: _trimController,
      decoration: InputDecoration(
        // fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.brown[500],
          ),
        ),
        labelText: 'Motor',
        //hintText: 'Exmplo: ' + 'Land Cruiser',
        //Disable The text Box
        icon: Icon(
          FontAwesomeIcons.carAlt,
          color: Colors.brown[500],
        ),
      ),
      //Open The Virtual KeyBoard on Phone
      keyboardType: TextInputType.text,
      validator: (String val) {
        if (val.isEmpty){
          return "Por Favor, Escreva o Modelo do Motor";
        }
      },
      autofocus: true,
    );
  }
  //LoginScreen(this.product);
  @override
  Widget build(BuildContext context) {
     String phone;
     var size = MediaQuery.of(context).size.width;
     //Get The Proforma Information.
     //Proforma _proforma;
    List<String> carModel;
    // VehicleData data;
    return ViewModelBuilder<ProformaViewModel>.reactive(
      disposeViewModel: false,
      builder: (context, modelView, child) => Scaffold(
        appBar: AppBar(
          title: Text('Proforma'),
          //centerTitle: TextAlign.center,
          backgroundColor: Colors.brown[500],
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 80.0),
              child: Form(
                autovalidate: false,
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                   // SizedBox(height: 8.0),
                    TextFormField(
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
                      controller: _marcaController,
                      decoration: InputDecoration(
                        fillColor: Colors.brown,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                        //labelText: 'peca',
                        // hintText: widget.carBrand,
                        hintText: modelView.vehicleMakeModel.toString(),
                        //Disable The text Box
                        enabled: false,
                        icon: Icon(
                          FontAwesomeIcons.car,
                          color: Colors.brown[500],
                        ),
                      ),
                      //Open The Virtual KeyBoard on Phone
                      keyboardType: TextInputType.text,
                      validator: (String val) {
                        if (modelView.vehicleMakeModel.toString() == true)
                          {
                            return val = modelView.vehicleMakeModel.toString();
                          }
                      },
                      autofocus: true,
                    ),
                    SizedBox(height: 40.0),
                    _buildModel(),
                    SizedBox(height: 40.0),
                    _buildChassis(),
                    SizedBox(height: 30.0),
                    _buildPeca(),
                    SizedBox(height: 40.0),
                    _buildYear(),
                    SizedBox(height: 30.0),
                    _buildTrim(),
                    SizedBox(height: 40.0),
                   //ImagesField(url: url,),
                   GestureDetector(
                      //Get The Image Picker
                      onTap: ()=> modelView.selectImage(),
                      child: Container(
                        height: 150,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          //borderRadius: BorderRadius.circular(10)
                        ),
                        alignment: Alignment.center,
                        child: modelView.selectedImage == null ?
                        Icon(
                          //Tap to Go Fetch an Image.
                          Icons.camera_alt,
                          size: 45,
                          color: Colors.white,
                        )
                            : Image.file(
                              modelView.selectedImage,
                              height: 150,
                              width: 180,
                        ),
                      ),
                    ),

                    SizedBox(height: 50.0),

                    NiceButton(
                      width: 255,
                      elevation: 8.0,
                      radius: 52.0,
                      text: "Solicitar",
                      background: Colors.brown[500],
                      textColor: Colors.white,
                      onPressed: () async
                      {
                       // String url1 = list.url;
                        //Please Validate The Form Fields
                        if (_chassisController.text.length == 9){

                          if (_formKey.currentState.validate()){
                            try {
                              marca = modelView.vehicleMakeModel.toString();

                              //Save Image
                              modelView.saveImage(title: marca);

                              modelView.getProfData(
                                  make: marca,
                                  model: _modelController.text.toString(),
                                  peca: _pecaController.text.toString(),
                                  vinNumber:  _chassisController.text.toString(),
                                  year: _yearController.text.toString(),
                                  trim: _trimController.text.toString(),
                              );
                            }
                            catch (e) {
                              print (e);
                            }
                            //Got to the Login Page.
                            context.rootNavigator.push(Routes.loginView);
                          }
                          else
                            print ('One of the Values is Wrong');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => locator<ProformaViewModel>(),
    );
  }
}
