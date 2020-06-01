import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //This is to create a background with pink colour nice one.
    Widget _buildBodyBack () => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 211, 118, 130),
              Color.fromARGB(255, 253, 181, 168)
            ],
                //Now Lets say the gradient will start on top left and finish on bottom right
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),
        ),
      );
      // Stack is to allow us to create something on top of the other
      return Stack (
        children: <Widget>[
          _buildBodyBack(),
          //This code allow when we move the contents th bar also moves.
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                //This allows the Top Bar in the title to move up whne ppl are scrolling up
                floating: true,
                //This the Title to show up as the floating start to disappear
                snap: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text('Novidades'),
                  centerTitle: true,
                ),
              ),
              FutureBuilder <QuerySnapshot>(
                //Get the Documents and Order by the Position.
                future: Firestore.instance
                    .collection("home").orderBy('pos').getDocuments(),
                //Builder will define what is in the screen depends upon what the future will be to me.
                builder: (context, snapshot){
                  //Validate if SnapShot has data
                  if(!snapshot.hasData)
                    //if does not has data please Create  Progress indicator
                    return SliverToBoxAdapter(

                      child: Container(
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  else
                    return SliverStaggeredGrid.count(
                      //crossAxisCount Specify the columns you have
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      //We Will Create a Stagering Tiles That Will Come With a List of Documents That Need To Be Map
                      //To a Static Function That Will Hold the values of That Comes from the DB.
                      staggeredTiles: snapshot.data.documents.map(
                              (doc){
                                return StaggeredTile.count(doc.data['x'], doc.data['y']);
                              }
                      ).toList() ,//Turn This staggered grid into a LIst,
                      children: snapshot.data.documents.map(
                          (doc){
                            return FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: doc.data['image'],
                                fit: BoxFit.cover,
                            );
                          }
                    ).toList(),
                    );
                },
              ),
            ],
          ),
        ],
      );
  }
}
