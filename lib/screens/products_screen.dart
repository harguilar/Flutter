import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/datas/cart_product.dart';
import 'package:jeilaonlinestore/datas/products_data.dart';
import 'package:jeilaonlinestore/models/cart_model.dart';
import 'package:jeilaonlinestore/models/user_model.dart';
import 'package:jeilaonlinestore/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';


class ProductScreen extends StatefulWidget {
  final ProductData product;
  ProductScreen(this.product);
  @override
  _ProductScreenState createState() => _ProductScreenState(this.product);
}

class _ProductScreenState extends State<ProductScreen> {
  //In order to use the Product Within your state you call also create a constructor within your state
  //And Pass the Product as Parameter to allow us to use throughout the Entire State.
  final ProductData product;
  String s;
  _ProductScreenState(this.product);
  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
        actions: <Widget>[
          Container (
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model){
                int p = model.products.length;
                //if P is Null return 0
                return Text('${p ?? 0} ${p == 1 || p == 0? "ITEM" : "ITENS"}',
                  style: TextStyle(fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      //Create a List view so that we can scroll up and Down
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              //We put the Map so that we can Transform the URLs into Images
              //From the Database.
              images: product.images.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotColor: primaryColor,
              dotBgColor: Colors.transparent,
              dotSpacing: 15.0,
              //Carousel Can change with Auto Play but set to false
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "AKZ\ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  'Tamanho',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView (
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    //Grid Should Go Horizontally
                    scrollDirection: Axis.horizontal,
                    //Create Grids with Fix Numbers of sizes and spacing
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    //Create an Automatic List View that read from the DB
                    children: product.sizes.map((size) {
                      //When User touch we want to Dectect it.
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            s=size;
                          });
                        },
                        child: Container(
                          //This defines all the Parameters with the Box and Borders
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                              //Check The Size and Define the Color.
                                color: s == size ? primaryColor : Colors.grey[500],
                                width: 3.0,
                            ),
                          ),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(size),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  //Define the Size of The Button.
                  height: 44.0,
                  child: RaisedButton(
                    //Disable The Button if size was not selected.
                    onPressed: s != null? (){
                      if (UserModel.of(context).isLoggedIn()){

                        //Adiciona ao Carrinho
                        CartProduct cartProduct = CartProduct();
                        //set the Size
                        cartProduct.size = s;
                        //set the Quantity to be add by 1
                        cartProduct.quantity = 1;
                        //Get the Product Id from the screen.
                        cartProduct.pid = product.id;
                        //
                        cartProduct.category = product.category;
                        //Add Itens to cart.
                        CartModel.of(context).addCartItems(cartProduct);
                      }
                      else {
                        //Send him to the Login Page.
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      }
                    } : null,
                    child: Text( UserModel.of(context).isLoggedIn() ?'Adicionar ao Carrinho'
                        : 'Entre Para Comprar',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Descrição',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
