class RegisterModel {
  String? fileName;
  String? downloadURL;
  String? fileType;
  int? fileSize;
  String? message;

  RegisterModel(
      {this.fileName,
      this.downloadURL,
      this.fileType,
      this.fileSize,
      this.message});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    downloadURL = json['downloadURL'];
    fileType = json['fileType'];
    fileSize = json['fileSize'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['downloadURL'] = this.downloadURL;
    data['fileType'] = this.fileType;
    data['fileSize'] = this.fileSize;
    data['message'] = this.message;
    return data;
  }
}
