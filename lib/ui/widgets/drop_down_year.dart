import 'package:flutter/material.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/*
class dropDown extends StatefulWidget {
  @override
  _dropDownState createState() => _dropDownState();
}


class _dropDownState extends State<dropDown> {
  @override
  Widget build(BuildContext context) {
    return  DropDownField(
      hintStyle: TextStyle(color: Colors.black,
      fontWeight: FontWeight.bold,
        fontSize: 14.0,
      ),
      controller: selectedYear,
      hintText: 'Seleciona o Ano do Carro',
      enabled: true,
      textStyle: TextStyle(
        fontSize: 14.0,

      ),
      itemsVisibleInDropdown: 5,
      icon: Icon(FontAwesomeIcons.calendar,
        color: Colors.brown[300]
      ),
      //Show me the Car years
      items: year,
      onValueChanged: (value){
        setState(() {
          selectYear = value;
        });
      },
    );
  }
}
*/


class MenuYear extends StatefulWidget {
  @override
  _menuYearState createState() => _menuYearState();
}

class _menuYearState extends State<MenuYear> {
  String selectYear ;
  List year =
            [
              '2000',
              '2001',
              '2002',
              '2003',
              '2004',
              '2005',
              '2006',
              '2007',
            ];
  @override
  Widget build(BuildContext context) {
    return
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0)
              ),
              padding: EdgeInsets.only(left: 50.0, right: 16.0),
              child: DropdownButton(
                hint: Text('Seleciona o Ano'),
                dropdownColor: Colors.transparent,
                elevation: 5,
                icon: Icon(Icons.arrow_drop_down),

                isExpanded: true,
                iconSize: 36.0,

                value: selectYear,

                onChanged: (value){

                  setState(()

                    {
                      selectYear = value;
                    }
                  );
                },
                items: year.map((value)
                {
                  return DropdownMenuItem
                    (
                      value: value,
                      child: Text(value),
                    );
                  }
                ).toList(),
              ),
            ),
          );
  }
}


