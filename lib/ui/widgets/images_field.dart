import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/helpers/const_global.dart';
import 'image_source_sheet.dart';
import 'package:path/path.dart';
import 'dart:io';

class ImagesField extends StatelessWidget {
  String url;
  ImagesField({@required this.url }) ;


  @override
  Widget build(BuildContext context) {
    return FormField<List>(
      validator: (images){
        if(images.isEmpty)
          return 'Com  foto da peça é mais fácil encontrar';
        else
          return null;
      },
      initialValue: [],
      builder: (state) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                color: Colors.grey,
                height: 130,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      if (index == state.value.length)
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => ImageSourceSheet(
                                  onImageSelected: (image) {
                                    if (image != null){
                                      ConstGlobal.img = image;
                                      state.didChange(state.value..add(image));
                                      uploadPic(context, image);
                                    }
                                    Navigator.of(context).pop();
                                  },
                                )
                            );
                          },
                          child: Padding(

                            padding: EdgeInsets.only(left: 130),
                            /*padding: const EdgeInsets.only(
                                left: 93, top: 16, bottom: 16),*/
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.camera_alt,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '+ Peça',
                                    style: TextStyle(color: Colors.white,),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      return GestureDetector(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context) =>Dialog(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Image.file(
                                        state.value[index],
                                        height: MediaQuery.of(context).size.height / 2,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      FlatButton(
                                        child: Text('Excluir'),
                                        textColor: Colors.red,
                                        onPressed: (){
                                          state.didChange(state.value..removeAt(index));
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  )
                              )
                          );
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, top: 0, bottom: 0),
                            child: Image.file(
                              state.value[index],
                              fit: BoxFit.cover,
                              width: 350,
                              height: 100,
                            )
                        ),
                      );
                    }),
              )
            ],
          ),
        );
      },
    );
  }
  Future uploadPic (BuildContext context, File image) async {
    String fileName=basename(image.path);
    StorageReference filrebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = filrebaseStorageRef.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

  }
}
