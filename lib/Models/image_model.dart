class ImageModel{
  String base64Image = '';
  String imagename = '';

  ImageModel({required this.base64Image, required this.imagename});

  ImageModel.fromJson(Map<String, dynamic> json ){
    base64Image = json['base64Image'];
    imagename = json['imagename'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['base64Image'] = base64Image;
    data['imagename'] = imagename;
    return data;
  }
}