class SocialMediaModel {
  bool? sucess;
  String? message;
  List<Data>? data;

  SocialMediaModel({this.sucess, this.message, this.data});

  SocialMediaModel.fromJson(Map<String, dynamic> json) {
    sucess = json['sucess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sucess'] = this.sucess;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? plateForm;
  String? thumbnail;
  String? link;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.title,
        this.plateForm,
        this.thumbnail,
        this.link,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    plateForm = json['plateForm'];
    thumbnail = json['thumbnail'];
    link = json['link'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['plateForm'] = this.plateForm;
    data['thumbnail'] = this.thumbnail;
    data['link'] = this.link;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}