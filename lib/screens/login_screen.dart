import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/models/user_model.dart';
import 'package:jeilaonlinestore/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  //Create a Key to Access the form
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign In",
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text("Sign Up",
              style: TextStyle(
                  fontSize: 16.0
              ),
            ),
            textColor: Colors.white,
            onPressed: () {
              //pushReplace ensure that once the User signup he already login.
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignUpScreen())
              );
            },
          ),
        ],
      ),
      //This is a way for us to access the Model and everytime we change something
      //in our class UserModel this whole code below will be rebuilt.
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {

          if (model.isLoading)
            return Center(child: CircularProgressIndicator(),);
          //Form allows us to Validate our Fields.
          //We must make sure that we are putting a Valid Email and Password.
          return Form(
            //Gain Access to Form key here.
            key: _formkey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  //To open a Virtual Keyboard,
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains('@'))
                      return "Invalid Email ";
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  //Ensure that We Hide the Text,
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Invalid Password ";
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {

                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    //Take The Padding of the Buttong
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(height: 16.0,),
                //Make Our Buttong Look Bigger

                SizedBox(height: 44.0,
                  child: RaisedButton(onPressed: () {
                    if (_formkey.currentState.validate()) {
                      print('DO LOGIN');
                    }
                    model.signIn();
                  },
                    child: Text('Sign In',
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
}

