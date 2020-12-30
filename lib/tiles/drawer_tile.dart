import 'package:flutter/material.dart';
class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    //Material is being used so that we can create a Visual Effect
    return Material(
      color: Colors.transparent,
      child: InkWell(
        //This is where we Change Each Page
        onTap:() {
          //This will hide/close the Drawer Once we Click into Page
          Navigator.of(context).pop();
          //This will Move into the Next Page.
          controller.jumpToPage(page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                //This is the ICON coming from the Class Parameter
                icon,
                size: 32.0,
                //This will check the page Number and Change The Color based on The Page where we are.
                color: controller.page.round() == page ?
                    //Give it The Primary Color otherwise give it grey.
                    Theme.of(context).primaryColor : Colors.grey[700],
              ),
              SizedBox(width: 32.0,),
              Text(
                //This is the Text coming from the Class Parameter
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: controller.page.round() == page ?
                     Theme.of(context).primaryColor : Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
