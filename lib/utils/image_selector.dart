import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageSelector {
  Future<File> selectImage () async {
    //Get the Image with the Preset of Height and Width
    return await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 150, maxWidth: 180);
  }
}