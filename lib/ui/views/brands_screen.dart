import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:gerente_loja/routes/router.gr.dart';
import 'package:gerente_loja/ui/views/startup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:gerente_loja/core/viewmodels/vehicleViewModel.dart';

class brandsScreens extends StatelessWidget {
  /*String user;
  brandsScreens({@required this.user});*/
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VehicleViewModel>.reactive(

      initialiseSpecialViewModelsOnce: true,
      //keep The State
      disposeViewModel: false,
      //Future Builder
      onModelReady: (model)=>model.getVehicleData(),
        builder: (context, model, child)=> model.vehicles != null ?
         Scaffold(
          appBar: AppBar(
              title: Text('Selecionar o Carro '),
              //centerTitle: TextAlign.center,
              backgroundColor: Colors.brown[500],
              centerTitle: true,
              actions: [
                //Text(user != '' ?  user.toUpperCase() : 'No Logged User'),
              ]
          ),
          backgroundColor: Colors.grey,
          body: ListView.builder(
            itemCount: model.vehicles.length,
            itemBuilder: (BuildContext context, index){
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: InkWell(
                  splashColor: Colors.blueGrey,
                  child: Card(
                    child: ListTile(
                      leading: AspectRatio(
                          aspectRatio: 0.8,
                          child: Image.network(
                            model.vehicles[index].icon,
                            height: 500,
                            fit: BoxFit.contain,
                          )
                      ),
                      title: Text(
                        model.vehicles[index].make,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18.0,
                          fontWeight: FontWeight.bold,),
                      ),
                      onTap: (){
                        //Route for Proforma Page
                        context.rootNavigator.push(Routes.proformaScreen);
                        model.model = model.vehicles[index].model;
                        model.make = model.vehicles[index].make;
                        //model.selectedCar = model.make;

                      } ,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              );
            },
          ),
        )
            :
              StartupView(),
      viewModelBuilder: ()=> VehicleViewModel(),
    );
  }
}





