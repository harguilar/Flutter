import 'package:flutter/material.dart';
import 'package:gerente_loja/core/datamodels/vehicle_user.dart';

class CustomDropDown extends StatefulWidget {

  List<VehicleUser> _listVehicleUsers;

  CustomDropDown(this._listVehicleUsers);



  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  bool seeImg = false;
  String _selectedValue;
  bool selectedSavedVehicle = false;


  @override
  Widget build(BuildContext context) {



    return DropdownButton(
      items:
      widget._listVehicleUsers.map((item) {
        return DropdownMenuItem(
            child: Container(
              width: 250.0,
              child: Text(
                item.make
                    .toUpperCase() +
                    " " +
                    item.model +
                    " " +
                    item.year
                        .toString(),
                textAlign:
                TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight:
                    FontWeight
                        .bold),
              ),
            ),
            value: item.id);
      }).toList(),
      onChanged: (value) {
//print(selectedVehicle.imgUrl);
        setState(() {
          seeImg = true;
          _selectedValue = value;

          selectedSavedVehicle = true;
        });
      },
      value: _selectedValue,
      isExpanded: true,
      hint: Center(
        child: Text(
          "Selecione dos seus veículos ",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight:
              FontWeight.bold,
              color: Colors.white,
              fontSize: 20),
        ),
      ),
      elevation: 16,
    );
  }
}






