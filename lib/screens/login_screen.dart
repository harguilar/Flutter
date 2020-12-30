import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/models/user_model.dart';
import 'package:jeilaonlinestore/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Create a Key to Access the form
  final _formkey = GlobalKey<FormState>();

  //Define The Controllers to loging
  final _emailController = TextEditingController();
  final _passwdController = TextEditingController();

  //Because we already have a scaffold key we must define global key to access anywhere.
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(
          "Sign In",
        ),
        centerTitle: true,
        //Create an Action Which will be just a single button to stay on top right corner
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  //To open a Virtual Keyboard,
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains('@'))
                      return "Username or Password Invalid ";
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwdController,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  //Ensure that We Hide the Text,
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Username or Password Invalid ";
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      //Check If Email is Empty
                      if (_emailController.text.isEmpty){
                        _scaffoldkey.currentState.showSnackBar(SnackBar
                          (content: Text("Enter Recovery Email"),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 2),
                        ));
                      }
                      else{
                        model.recoverPass(_emailController.text);
                        _scaffoldkey.currentState.showSnackBar(SnackBar
                          (content: Text("Confirm Your Email "),
                          backgroundColor: Theme.of(context).primaryColor,
                          duration: Duration(seconds: 2),
                        ));
                      }
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    //Take The Padding of the Button
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(height: 16.0,),
                //Make Our Buttong Look Bigger

                SizedBox(height: 44.0,
                  child: RaisedButton(onPressed: () {
                    //In Order to Access The Validators we Must create a Form
                    //Global Key on Top. and access it where you want to validate your fields.
                    if (_formkey.currentState.validate()) {
                      // print('DO LOGIN');
                      model.signIn(
                          email: _emailController.text,
                          pass: _passwdController.text,
                          onSucess: _onSucess,
                          onFailure: _onFail
                      );
                    }
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

  void _onSucess(){
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldkey.currentState.showSnackBar(SnackBar
      (content: Text("Fail To Login"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));

  }
}