import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerente_loja/core/models/message.dart';
import 'package:gerente_loja/core/models/proforma.dart';
import 'package:gerente_loja/core/models/user.dart';
import 'package:gerente_loja/helpers/const_global.dart';

class ChatProvider {
  static var rootRef = Firestore.instance;
  var userContactsRef = Firestore.instance.collection('contacts');
  var uidRef = rootRef.collection('users');
  FirebaseUser firebaseUser;

  Future<Message> getMesssages() async {
    ConstGlobal.getCurrentUser().then((value) => firebaseUser = value);

        bool connectionState = await DataConnectionChecker().hasConnection;

   if(connectionState) {
     if (firebaseUser != null) {
       var fromUid = firebaseUser.uid;
       var uidRef = rootRef.document(fromUid);
       uidRef.get().then((documentSnapshot) async {
         if (documentSnapshot.exists) {
           User fromUser = User.fromDocument(documentSnapshot);
           QuerySnapshot snapshot = await userContactsRef
               .document(fromUid)
               .collection('userContacts')
               .getDocuments();
           List<String> listOfToUserNames = [];
           List<User> listOfToUsers = [];
           List<String> listOfRooms = [];
           snapshot.documents.forEach((DocumentSnapshot snapshot) {
             listOfToUserNames.add(User
                 .fromDocument(snapshot)
                 .name);
             listOfToUsers.add(User.fromDocument(snapshot));
             listOfRooms.add(snapshot.documentID);
           });
         }
       });
     }


   }
  }


  saveProforma(Proforma proforma) async {
    // await ref.document().setData(proforma.toJson());
  }
}
