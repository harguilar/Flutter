import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/models/user_model.dart';
import 'package:jeilaonlinestore/screens/login_screen.dart';
import 'package:jeilaonlinestore/screens/signup_screen.dart';
import 'package:jeilaonlinestore/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

//This Class Controls The Page.
class CustomDrawer extends StatelessWidget {
  //This Will Control de Moviment Between Pages.
  final PageController pageController;

  CustomDrawer(this.pageController);
  @override
  Widget build(BuildContext context) {
    //This Widget is to give nice Colour of the top heading
    Widget _buildDrawerBack () => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 203, 236, 241),
              Colors.white,
            ],
            //Now Lets say the gradient will start on top left and finish on bottom right
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
        ),
      ),
    );
    //Lets Return a Drawer cz we are creating one.
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          //Create a List View For your Items
          ListView(
            //Define The borders with in your list
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack (
                  children: <Widget>[
                    Positioned (
                      top: 8.0,
                      left: 0.0,
                      child: Text( 'Jeila \nClothing Line',
                        style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant <UserModel>(
                        builder: (context, child, model){
                          //print (model.isLoading);
                          return Column(
                            //This will align things a bit to the lef
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                //Check if someone is logged in.
                                'Ola, ${!model.isLoggedIn() ? "" : (model.userData['name'])}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //In order to create a text with link we create a Gesture Detector
                              GestureDetector(
                                child:  Text(
                                  !model.isLoggedIn() ?
                                  'Entre ou cadastra-se >' : "Sair",
                                  //This will Get the primary color we defined in the home.
                                  style: TextStyle (
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: (){
                                  if (!model.isLoggedIn())
                                    //This is a Function of Gesture Detector.
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                                 else
                                   model.signOut();
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //This is Like an Horizontal line
              Divider(),
              DrawerTile(Icons.home, 'Home', pageController,0), //This is Where we are Changing Pages
              DrawerTile(Icons.list, 'Products', pageController, 1),
              DrawerTile(Icons.location_on, 'Shops', pageController, 2),
              DrawerTile(Icons.playlist_add_check, 'My Requests', pageController,3),
            ],
          ),
        ],
      ),
    );
  }
}
