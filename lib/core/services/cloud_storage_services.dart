import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gerente_loja/core/datamodels/proforma_data.dart';
import 'package:gerente_loja/core/services/proforma_services.dart';
import 'package:gerente_loja/core/viewmodels/cloud_storage_result.dart';
import 'package:gerente_loja/locator.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class CloudStorageService {
  var url;
  final _db = Firestore.instance;

  Future <CloudStorageResult> uploadImage({@required File imageToUpload, @required String title,}) async {
    try {
      final ProformaServices _proformaServices = locator<ProformaServices>();

      //Create File Name and give a Unique timeline.
      var imageFileName = title + DateTime.now().millisecondsSinceEpoch.toString();

      //Get a Reference to the File that we want to create.
      final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(imageFileName);

      //upload the file
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);

      //Get information on the uploaded file
      var storageSnapshot = await uploadTask.onComplete;


      if (storageSnapshot != null){

       var downloadUrl = await storageSnapshot.ref.getDownloadURL();
        if (uploadTask.isComplete){
          //Get the URL
          url = downloadUrl.toString();
          //GET THE URL DO SAVE INTO THE PROFORMA
          _proformaServices.saveProforma(url);
          //urlImage(url);
        }
        return CloudStorageResult(
            imgUrl: url,
            imageFileName: imageFileName
        );
      }
      //Return Null if it fails
      return null;
    }
    catch (e){
      print (e);
    }
  }
/*  String urlImage ( String imageUrl){
     return imageUrl;
  }*/
}