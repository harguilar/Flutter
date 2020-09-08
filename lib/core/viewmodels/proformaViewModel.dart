import 'dart:io';

import 'package:gerente_loja/core/datamodels/proforma_data.dart';
import 'package:gerente_loja/core/services/cloud_storage_services.dart';
import 'package:gerente_loja/core/services/proforma_services.dart';
import 'package:gerente_loja/core/services/sellectedVehicleDetails.dart';
import 'package:gerente_loja/core/viewmodels/cloud_storage_result.dart';
import 'package:gerente_loja/locator.dart';
import 'package:gerente_loja/utils/image_selector.dart';
import 'dart:core';
import 'package:stacked/stacked.dart';

class ProformaViewModel extends BaseViewModel {
  String imageUrl;

  //Private Variables
  final SellectedVehicleDetails _collectedVehicleDetails = locator<SellectedVehicleDetails>();

  CloudStorageResult _storageResult = locator<CloudStorageResult>();

  //Get the Image
  final ImageSelector _imageSelector = locator <ImageSelector>();

  //Get The Proforma Information.
  final ProformaData _profData = locator<ProformaData>();


  final ProformaServices _proformaServices = locator<ProformaServices>();

  CloudStorageService _cloudStorageService = locator<CloudStorageService>();

  String _profVehicleMake;

  get vehicleMakeModel => _collectedVehicleDetails.vehicleMake;

  File _selectedImage;

  File get selectedImage => _selectedImage;

  //Display The Image In UI when Selected
  Future selectImage() async {

    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null){
      //Show The Image Inside UI when Selected.
      _selectedImage = tempImage;
      notifyListeners();
    }
  }
  //Upload Image to Firebase.
  saveImage ({String title}) async{
    _storageResult = await _cloudStorageService.uploadImage(
        imageToUpload: _selectedImage,
        title: title,
    );
  }
  getProfData({String make, String model, String vinNumber, String peca, String url})
  {
       // if (imgUrl != null){}
       _profData.make = make;
       _profData.model = model;
       _profData.vinNumber = vinNumber;
       _profData.peca = peca;
      // _profData.imgUrl =  _cloudStorageService.urlImage(imageUrl);
      // _profData.imgUrl =  url;

       setBusy(true);
       _proformaServices.setProforma(_profData);

       setBusy(false);
       //return _profData;
  }
  //Vehicles Details
   getMake() => _profVehicleMake = _collectedVehicleDetails.vehicleMake;

   notifyListeners();
}
