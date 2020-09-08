import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerente_loja/core/services/authentication.dart';
import 'package:gerente_loja/ui/views/proforma_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'brands_screen.dart';

class LoginPageScreen extends StatefulWidget {
  @override
  _LoginPageScreenState createState() => _LoginPageScreenState();
}
class _LoginPageScreenState extends State<LoginPageScreen> {
 // String carBrand;

  bool _rememberMe = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

   Authentication authUser = Authentication();
    void OnGoogleSignIn(BuildContext context) async {
          try {
              FirebaseUser user = await authUser.getUserGmail();

              String user1 = user.displayName;
             /* Navigator.push(context,
                    MaterialPageRoute(builder: (context) => brandsScreens(user1)));*/
          }
          catch (error){
                  print (error.toString());
          }
      }

  _buildEmail (){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[
        Text('Email',
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          //decoration:,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.email,
                color: Colors.brown[500],
              ),
              hintText: "Enter Your email",
              // hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  _buildPassword(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[
        Text('Password',
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          //decoration:,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.lock,
                color: Colors.brown[500],
              ),
              hintText: "Enter Your Password",
              // hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  _buildForgotButton (){
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
          padding: EdgeInsets.only(right: 0.0),
          onPressed: (){
            print('Forgot Your Password');
          },
          child: Text('Forgot Password ?')
      ),
    );
  }
  _buildRememberMeCheckBox (){
    return   Container(
      height: 20.0,
      child: Row(
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.brown[500]),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.brown,
              onChanged: (value){
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text("Remember Me",
            style: TextStyle( fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
  _buildLoginButton(){
    return Container (
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          print ('Login Button Pressed');
        } ,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.brown[500],
        child: Text('Login',
          style: TextStyle(color:  Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  _buildSignButton(){
    return Column(
      children: [
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sing in With',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
  _buildSocialMedia(){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              print ('Login Facebook');
            },
            child: Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage('images/facebook.png'),
                  )
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              OnGoogleSignIn(context);
            },
            child: Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage('images/google.jpg'),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
  _buildSignUpButton(){
    return GestureDetector(
      onTap: (){
        print ('Sign Up Button');
      },
      child: RichText(
        text: TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have na Account ?',
                style: TextStyle(color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
        ),
      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Stack(
              children: <Widget> [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black12,
                        Colors.grey[500],
                        Colors.black12,
                      ],
                      //  stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(physics: AlwaysScrollableScrollPhysics(),padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment:  MainAxisAlignment.center,
                      children:<Widget> [
                        Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                          ),
                         ),
                        SizedBox(height: 30.0),
                        _buildEmail (),
                        SizedBox(height: 30.0),
                        _buildPassword(),
                        _buildForgotButton(),
                        _buildRememberMeCheckBox(),
                        _buildLoginButton(),
                        _buildSignButton(),
                        _buildSocialMedia(),
                        _buildSignUpButton(),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
