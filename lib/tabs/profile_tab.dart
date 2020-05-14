import 'package:flutter/material.dart';




class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
  const ProfileTab({Key key}) : super(key: key);
}

class _ProfileTabState extends State<ProfileTab> {


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
          body:  Stack(
                  children: <Widget>[
                    ClipPath(
                      child: Container(color: Theme.of(context).primaryColor),
                      clipper: GetClipper(),
                    ),
                    Positioned(
                        width: 350.0,
                        top: MediaQuery.of(context).size.height / 5,
                        child: Column(
                          children: <Widget>[
                            Container(
                                width: 150.0,
                                height: 150.0,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/pistom-fdd86.appspot.com/o/pistom_logo.jpg?alt=media&token=a2a5db7b-5c33-41a6-b254-730725e709f8'),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.all(Radius.circular(75.0)),
                                    boxShadow: [
                                      BoxShadow(blurRadius: 7.0, color: Colors.black)
                                    ])),
                            SizedBox(height: 65.0),
                            Text(
                              /*model.buyerData['name']*/
                              "Hendrick Jr Manenga",
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'tom@gmail.com',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              '+244 942688410',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),

                            SizedBox(height: 30.0),
                         /*   Container(
                                height: 30.0,
                                width: 95.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Colors.greenAccent,
                                  color: Colors.green,
                                  elevation: 7.0,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Center(
                                      child: Text(
                                        'Editar o nome',
                                        style: TextStyle(color: Colors.white, fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )),*/
                            SizedBox(height: 25.0),
                        /*    Container(
                                height: 30.0,
                                width: 150.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Colors.green,
                                  color: Colors.green,
                                  elevation: 7.0,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Center(
                                      child: Text(
                                        'Contactar a Pistom',
                                        style: TextStyle(color: Colors.white, fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(height: 25.0),*/
                            Container(
                                height: 30.0,
                                width: 95.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Colors.green,
                                  color: Colors.green,
                                  elevation: 7.0,
                                  child: GestureDetector(
                                    onTap: () { /*model.signOut();*/},
                                    child: Center(
                                      child: Text(
                                        'Sair',
                                        style: TextStyle(color: Colors.white, fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
                                      ),





                                    ),
                                  ),
                                )),



                          ],
                        ))
                  ],
                )


    );
  }
}//End of my state class


class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }




}


