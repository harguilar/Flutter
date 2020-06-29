import 'package:flutter/material.dart';


class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex=0;
  final List<String> categories =['Messagens','Online'];


  
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 82.0,
      color: Color.fromRGBO(64, 75, 96, .9),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
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
                child: Text(categories[index],style: TextStyle(
                    color: index== selectedIndex? Colors.white: Colors.white60,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,

                letterSpacing: 1.2) ,
                ),
              ),
            );


          }


      ),


    );
  }
}
