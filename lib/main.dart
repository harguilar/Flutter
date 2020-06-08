import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/models/cart_model.dart';
import 'package:jeilaonlinestore/models/user_model.dart';
import 'package:jeilaonlinestore/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Define the Scopped Model and its Data Type
    //To affect the entire App we must also define scoped Model within The home
    //of Our Page.
    return ScopedModel<UserModel>(
      //Now lets create a New user Model
      model: UserModel(), //This states that anything below user Model will have access to the class UserModel
      //Everytime we change Users We Want it to Rebuild My Cart so that a new user get it right data.

      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){

          return ScopedModel<CartModel>(
            //Make Cart model to have access to Current User.
            model: CartModel(model),

            child: MaterialApp(

              title: 'Loja de Roupas',
              theme: ThemeData(

                  primarySwatch: Colors.blue,
                  primaryColor: Color.fromARGB(255, 4, 125, 141)

              ),
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
