import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();

  //Because we already have a scaffold key we must define global key to access anywhere.
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  //Define the Controllers to Get the Text.
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwdController = TextEditingController();
  final _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Now Put the Key under Scaffold.
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Sign Up',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          //print (model.isLoading);
          if (model.isLoading)
            return Center (child: CircularProgressIndicator(),);
          return  Form(
            key: _formkey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: ('Full Name:')
                  ),
                  validator: (text) {
                    if (text.isEmpty) return "Invalid Name";
                  },

                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: ('E-mail:')
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains('@'))
                      return "Invalid Email ";
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwdController,
                  decoration: InputDecoration(
                      hintText: ('Password:')
                  ),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Invalid Password";
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      hintText: ('Address:')
                  ),
                  validator: (text) {
                    if (text.isEmpty)
                      return "Invalid Address";
                  },
                ),
                SizedBox(height: 16.0),
                SizedBox(height: 44.0,
                  child: RaisedButton(onPressed: () {
                    if (_formkey.currentState.validate()) {
                      //Create a Map for Our Data to Save UserData
                      //Note We did not pass the Passwd for Security so that none can go to DB and see the Passwd within
                      //user Information.
                      Map<String, dynamic>userData = {
                        'name': _nameController.text,
                        'email': _emailController.text,
                        'address': _addressController.text,

                      };
                      //print (userData['name']);
                      //User Signing up
                      model.signUp(userData: userData,
                        pass: _passwdController.text,
                        onSucess: _onSucess,
                        onFailure: _onFail,
                      );
                    }
                  },
                    child: Text('Sign Up',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme
                        .of(context)
                        .primaryColor,
                  ),

                )
              ],

            ),
          );
        },
      ),
    );
  }
  void _onSucess(){
    _scaffoldkey.currentState.showSnackBar(SnackBar
      (content: Text("User created successfully"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    //Leave The main Screen After you finish creating the user.
    Future.delayed(Duration(seconds: 2)).then((value) => Navigator.of(context).pop());

  }
  void _onFail(){
      _scaffoldkey.currentState.showSnackBar(SnackBar
      (content: Text("Fail To create User"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

}


