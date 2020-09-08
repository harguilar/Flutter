import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class ImageSourceSheet extends StatelessWidget {

  final Function(File) onImageSelected;
  var url;

  ImageSourceSheet({this.onImageSelected, this.url});

  void imageSelected(File image) async {
    if(image != null){
      File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
       // ratioX: 1.0,
       // ratioY: 1.0
      );
      onImageSelected(croppedImage);
    }
  }

  Future uploadPic (BuildContext context, File image) async {
    String fileName=basename(image.path);
    StorageReference filrebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = filrebaseStorageRef.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;


  }


  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: (){},
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            child: Text("Câmera"),
            onPressed: () async {
              var image = await ImagePicker.pickImage(source: ImageSource.camera);
              uploadPic(context,image);
              imageSelected(image);
            },
          ),
          FlatButton(
            child: Text("Galeria"),
            onPressed: () async {
              var image = await ImagePicker.pickImage(source: ImageSource.gallery);
              uploadPic(context,image);
              imageSelected(image);
            },
          )
        ],
      ),
    );
  }
}
