import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../text_composer.dart';


class ChatTab extends StatefulWidget {


  @override
  _ChatTabState createState() => _ChatTabState();
  

}

class _ChatTabState extends State<ChatTab> {

  _ChatTabState();
  final GoogleSignIn googleSignIn =GoogleSignIn();
  FirebaseUser _currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
        _currentUser=user;
    }
    );
  }

  Future<FirebaseUser> _getUser()async{

    if(_currentUser != null) return _currentUser;


    try{
      final GoogleSignInAccount googleSignInAccount= await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication=
          await googleSignInAccount.authentication;
      final AuthCredential credential =GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final AuthResult authResult = 
      await FirebaseAuth.instance.signInWithCredential(credential);

      final FirebaseUser user = authResult.user;

      return user;

    }
    catch(error){
      return null;
      
    }
  }

  void _sendMessage({String text, File imgFile})async{
    final FirebaseUser user = await _getUser();

    Map<String, dynamic> data ={
      "uid": user.uid,
      "senderName": user.displayName,
      "senderPhotoUrl": user.photoUrl

    };
    if(user==null){
      _scaffoldKey.currentState.showSnackBar((
          SnackBar(
            content: Text('Não foi possivel fazer o Login.Tente novamente'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          )
      )
      );
    }


    if(imgFile!=null){
      StorageUploadTask task = FirebaseStorage.instance.ref().child('messagePhotos').child(
          DateTime.now().millisecondsSinceEpoch.toString()
      ).putFile(imgFile);

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      data['imgUrl'] = url;
    }
    if(text!=null)data['text']=text;

    Firestore.instance.collection('messages').add(data);


  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
    title: Text('olá'),
        elevation: 0.0,

      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('messages').snapshots(),
              builder: (context, snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.none:
                case ConnectionState.waiting:
                    return Center(
                      child:  CircularProgressIndicator(),
                    );
                default :
                  List <DocumentSnapshot> documents =snapshot.data.documents.reversed.toList();
                  
                  return ListView.builder(
                      itemCount: documents.length,
                      reverse: true,
                      itemBuilder: (context, index){
                        return ListTile(
                          title:Text(documents[index].data['text']) ,
                        );

                      });


              }


              },
            ),
          )
          ,
          TextComposer(_sendMessage),
        ],
      ),



    );


  }


}
