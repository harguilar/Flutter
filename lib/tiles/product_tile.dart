import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/datas/products_data.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);
  @override
  Widget build(BuildContext context) {
    //Inkwell Allow us to provide animation in some Widgets such as Cards etc.
    return InkWell(
      child: Card(
        child: type == 'grid'?
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start, //This will put the Image in the start.
            children: <Widget>[
              //We want the Image to have the same size in every device
              //That is why we defined the expect Ratio.
              AspectRatio (
                aspectRatio: 0.8,
                child: Image.network(
                    product.images[0],
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),

                      ),
                      //THE 2 THERE IS TO DEFINE DECIMAL PLACES
                      Text("AKZ\ ${product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 17.0,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          )
          : Row(
              children: <Widget>[

          ],
        )
      ),

    );
  }
}
