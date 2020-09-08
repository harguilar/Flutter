/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/core/models/user_profile.dart';
import 'package:gerente_loja/helpers/const_global.dart';
import 'package:gerente_loja/ui/screens/login_screen.dart';
import 'package:gerente_loja/ui/widgets/custom_app_bar.dart';


class ProfileTab extends StatefulWidget {

  @override
  _ProfileTabState createState() => _ProfileTabState();
  const ProfileTab( {Key key}) : super(key: key);
}

class _ProfileTabState extends State<ProfileTab> {

  bool isVendor;
  Future<UserProfile> user;
  */
/*String name = ConstGlobal.userData["name"],
      email = ConstGlobal.userData["email"],
      phone = ConstGlobal.userData["phone"],
      address = ConstGlobal.userData["address"];*//*



  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();





  @override
  Widget build(BuildContext context) {
    user= ConstGlobal.getUserProfile();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        appBar: appBar(context,  'PERFIL DO UTILIZADOR'),
        body: Stack(
          children: <Widget>[
            Positioned(
                width: 350.0,
                top: size.height / 5,
                child: FutureBuilder(
                  future: user,
                  builder: (context,snapshot){
                    if(! snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    else
                      {
                        // user= snapshot.data;
                        return Column(
                          children: <Widget>[
                            Container(
                              width: size.width / 3.5,
                              height: size.width / 3.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(75.0)),
                                  boxShadow: [
                                    BoxShadow(blurRadius: 7.0, color: Colors.black)
                                  ]),
                              child: Center(
                                child: Text(
                                  snapshot.data.name
                                      ?.toString()
                                      ?.substring(0, 1),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.0),
                            Text(
                              snapshot.data.name?.toString() ?? "Sem nome",
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              snapshot.data.email?.toString() ?? "Sem E-mail",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              snapshot.data.phone?.toString() ??
                                  "Sem telefone",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                                height: 30.0,
                                width: 95.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Theme.of(context).primaryColor,
                                  color: Theme.of(context).primaryColor,
                                  elevation: 7.0,
                                  child: GestureDetector(
                                    onTap: () => showDialogEditProfile(),
                                    child: Center(
                                      child: Text(
                                        'Editar o perfil',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(height: 25.0),
                            Container(
                                height: 30.0,
                                width: 125.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Theme.of(context).primaryColor,
                                  color: Theme.of(context).primaryColor,
                                  elevation: 7.0,
                                  child: GestureDetector(
                                    onTap: () async {
                                      showDialog(
                                          context: context,
                                          builder: (context) => Center(
                                            child: CircularProgressIndicator(),
                                          ));

                                      await FirebaseAuth.instance.signOut().then((_) {
                                        Navigator.pop(context);

                                        Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) => LoginScreen()),
                                                (Route<dynamic> route) => false);
                                      });
                                    },
                                    child: Center(
                                      child: Text(
                                        'Terminar sessão',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(height: 25.0),
                            */
/* Container(
                          height: 30.0,
                          width: 150.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.green,
                            color: Colors.green,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {





                              },
                              child: Center(
                                child: Text(
                                  'Contactar a Pistom',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),*//*

                            SizedBox(height: 25.0),
                          ],
                        );



                      }




                  },

                )

            )
          ],
        ));
  }

  showDialogEditProfile() => showDialog(
      context: context,
      builder: (context) {
          UserProfile newUser;
        return AlertDialog(
          title: Text("Editar Perfil"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  initialValue: ConstGlobal.userData["name"],
                  decoration: InputDecoration(
                      labelText: "Nome", border: OutlineInputBorder()),
                  onChanged: (value) =>newUser.name = value,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: ConstGlobal.userData["email"],
                  decoration: InputDecoration(
                      labelText: "E-mail", border: OutlineInputBorder()),
                  onChanged: (value) =>  newUser.email = value,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: ConstGlobal.userData["phone"],
                  decoration: InputDecoration(
                      labelText: "Telefone", border: OutlineInputBorder()),
                  onChanged: (value) =>  newUser.phone = value,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: ConstGlobal.userData["address"],
                  decoration: InputDecoration(
                      labelText: "Endereço", border: OutlineInputBorder()),
                  onChanged: (value) =>  newUser.address = value,
                )
              ],
            ),
          ),
          actions: <Widget>[
            StreamBuilder<DataConnectionStatus>(
              stream: DataConnectionChecker().onStatusChange,
              builder: (context,snapshot){
                if(snapshot.data==DataConnectionStatus.disconnected){

                  return Text('Sem internet!');

                }
                else
                  return FlatButton(
                    child: Text("Salvar"),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: CircularProgressIndicator(),
                          ));



                      await Firestore.instance
                          .collection("users")
                          .document(ConstGlobal.user.uid)
                          .updateData(newUser.toJson())
                          .then((_) {
                        setState(() {
                          ConstGlobal.userData = newUser.toJson();
                        });

                        Navigator.pop(context);
                        Navigator.pop(context);

                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text("Dados editados com successo !")));
                      }).catchError((e) {
                        print(e.toString());
                        Navigator.pop(context);
                        Navigator.pop(context);

                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              "Ocorreu um erro, tente mais tarde",
                              style: TextStyle(color: Colors.white),
                            )));
                      });
                    },
                  );

              },

            ),
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      });
} //End of my state class
*/
