import 'package:flutter/material.dart';


class MenuSelector extends StatefulWidget {
  @override
  _MenuSelectorState createState() => _MenuSelectorState();
}

class _MenuSelectorState extends State<MenuSelector> {
  int selectedIndex=0;
  final List<String> menuVendor =['Minhas Peças','Proformas','Pedidos'];
  final List<String> menuBuyer =['Pedir Proformas','Minhas Proformas','Pedidos','Perfil'];


  
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 82.0,
      color: Color.fromRGBO(64, 75, 96, .9),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menuVendor.length,
          itemBuilder: (BuildContext context, int index)
          {
            return GestureDetector(
              onTap:(){
                setState(() {
                  selectedIndex=index;
                });

              } ,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
                child: Text(menuVendor[index],style: TextStyle(
                    color: index== selectedIndex? Colors.amber: Colors.white60,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,

                letterSpacing: 1.2) ,
                ),
              ),
            );


          }


      ),


    );
  }
}
