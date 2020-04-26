class UploadImageModel {
  String base64Image;

  UploadImageModel({this.base64Image});

  Map<String, dynamic> toJson() =>
      {'base64Image': base64Image.toString()};
}