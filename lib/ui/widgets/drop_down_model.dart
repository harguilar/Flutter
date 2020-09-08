import 'package:flutter/material.dart';
import 'package:gerente_loja/core/viewmodels/vehicleViewModel.dart';
import 'package:gerente_loja/locator.dart';
import 'package:stacked/stacked.dart';

class MenuModel extends StatefulWidget {

  @override
  _menuModelState createState() => _menuModelState();
}
class _menuModelState extends State<MenuModel> {

  //var carModel;
  var model ;

  @override
  Widget build(BuildContext context) {

   String selectModel;

    return ViewModelBuilder<VehicleViewModel>.reactive(
        builder: (context, modelView, child){
          model = modelView.model;
      return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(25.0)
          ),
          padding: EdgeInsets.only(left: 50.0, right: 16.0),
          child: DropdownButton(
            hint: Text(modelView.model.toString()),
            dropdownColor: Colors.transparent,
            elevation: 5,
            icon: Icon(Icons.arrow_drop_down),
            isExpanded: true,
            iconSize: 36.0,
            value: selectModel,
            onChanged: (value){
              setState(() {
                if (modelView.model ==  null){
                  print ('Car Model is Blanked');
                  return CircularProgressIndicator();
                }
                else

                  selectModel = value;
              });
            },
            items: model.map<Widget>((value) {
              return DropdownMenuItem (
                  value: value,
                  child: Text(value));
            }).toList(),
          ),
        ),
      );
     },
      viewModelBuilder: ()=> locator<VehicleViewModel>(),
    );
  }

}

