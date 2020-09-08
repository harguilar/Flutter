class CloudStorageResult {
  String imgUrl;
  final String imageFileName;
  CloudStorageResult({this.imgUrl, this.imageFileName});

  get imgURL => imgUrl;
  set setImgUrl (String url){
    imgUrl = url;
  }
}