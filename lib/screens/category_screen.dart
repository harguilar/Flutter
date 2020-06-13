import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/datas/products_data.dart';
import 'package:jeilaonlinestore/models/cart_model.dart';
import 'package:jeilaonlinestore/screens/cart_screen.dart';
import 'package:jeilaonlinestore/tiles/product_tile.dart';
import 'package:scoped_model/scoped_model.dart';
class CategoryScreen extends StatelessWidget {
  //The Snapshot Gets the Category where we are Eg. Camisolas.
  //Get the Category where we are Surfing.
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  //Create an Object Type Cart
 // final int numProducts;
  // CartScreen prod = CartScreen(this.numProducts);

  @override
  Widget build(BuildContext context) {

    //Create a Tab
    return DefaultTabController(
      //create 2 Tabs
      length: 2,
      child: Scaffold(
        appBar: AppBar(

          title: Text(snapshot.data['title']),
          //Centralize The Title
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
          //Create a Tab at The Bottom
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on),),
              Tab(icon: Icon(Icons.list)),
            ],
          ),
        ),
        //DocumentSnapshot is a photo on a single Document while Query SnapShot is a photo of a collection
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection('products').document(snapshot.documentID)
              .collection('items').getDocuments(),
          //The SnapShot below indicates each Document within our Category/Product.
          //This One indicates every single Document with your category
          builder: (context, snapshot ){
            if (!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            else {
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  //Create Gridview so that instead of displaying every item at once it will display as you scroll down
                  //This will allow the App for not being to heavy
                  GridView.builder(
                      padding: EdgeInsets.all(4.0),
                      //This tell how many itens we should have in the horizontal
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        //This the Width/height = AspectRatio
                        childAspectRatio: 0.65,
                      ),
                      //How many Itens will hv in our grid. The snapshot is the one the
                      itemCount: snapshot.data.documents.length,

                      itemBuilder: (context,index){
                        //Create a Category of Each Product.
                        //Get the Doc and Convert it to Product Data.
                        ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                        //Get the Category ID of the Product for later usage.
                        data.category = this.snapshot.documentID;
                        return ProductTile('grid', data);
                      },

                  ),
                 ListView.builder(
                     padding: EdgeInsets.all(4.0),
                     itemCount: snapshot.data.documents.length,
                     itemBuilder: (context, index){
                       //Create a Category of Each Product.
                       //Get the Doc and Convert it to Product Data.
                       ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                       //Get the Category ID of the Product for later usage.
                       data.category = this.snapshot.documentID;
                       return ProductTile('List', data);
                     }
                 ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
