import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jeilaonlinestore/datas/products_data.dart';

class DataSearch extends SearchDelegate<String>{
  static int index = 0;
  static DocumentSnapshot snapshot;
  ProductData data = ProductData.fromDocument(snapshot);

  final cities = [
    'Luanda',
    'Benguela',
    'Huambo',
    'Kuando Kubango',
    'Huila'
  ];

  final recentCities = ['Luanda', 'Benguela'];
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    //Define the Actions for the App Bar
    //The is the Cross that shows in the right corner
    return [IconButton(icon: Icon(Icons.clear),
        onPressed: (){
      //Query should be empty
      query = '';
    })
    ];
  }
  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    //Leading Icon on the Left of the App

    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          //We want to provide some Animation into this progress.
          progress: transitionAnimation,
        ),
        onPressed: (){
          //close the search windows
          close(context, null);
          // Navigator.of(context,).pushReplacement(MaterialPageRoute(builder: (context)=>HomeTab()));
        }
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //Show The Result Based on the Selection.
    //Send it to the product page if the user is logged in otherwise request him to login.
  }
  @override
  Widget buildSuggestions(BuildContext context)  {
    String title = data.title;
    print (title);
   // Future<List> task =  getProductTitle();
    // TODO: implement buildSuggestions
    //Display The Results of the Search
    final suggestionList = query.isEmpty
        ? recentCities
    //Search Based on what user is input
        : cities.where((searchString) => searchString.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index)=> ListTile(
        onTap: (){
          //This is the Result of the search query
          showResults(context);
        },
        leading: Icon(Icons.location_city),
        //Make your Search highlight for each character that matches your search R.
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0,query.length),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}

/*

    Future<List>getProductTitle()async{

      QuerySnapshot qShot = await Firestore.instance.collection('products').getDocuments();

      return qShot.documents.map((doc) => doc.data['title'],

      ).toList();

}*/
