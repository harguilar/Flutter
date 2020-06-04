import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/datas/products_data.dart';
import 'package:jeilaonlinestore/tiles/product_tile.dart';
class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

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
          builder: (context, snapshot){
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
                        return ProductTile('grid', ProductData.fromDocument(snapshot.data.documents[index]));
                      },

                  ),
                 ListView.builder(
                     padding: EdgeInsets.all(4.0),
                     itemCount: snapshot.data.documents.length,
                     itemBuilder: (context, index){
                       return ProductTile('List', ProductData.fromDocument(snapshot.data.documents[index]));
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
