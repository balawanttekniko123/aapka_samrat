class PoliciesModel {
  bool? status;
  int? totalResult;
  int? totalPage;
  String? message;
  List<Data>? data;

  PoliciesModel(
      {this.status, this.totalResult, this.totalPage, this.message, this.data});

  PoliciesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResult = json['totalResult'];
    totalPage = json['totalPage'];
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
    data['status'] = this.status;
    data['totalResult'] = this.totalResult;
    data['totalPage'] = this.totalPage;
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
  String? summary;
  Null? policyCategory;
  String? link;
  String? thumbImage;
  List<String>? image;
  String? createdAt;
  int? iV;

  Data(
      {this.sId,
        this.title,
        this.summary,
        this.policyCategory,
        this.link,
        this.thumbImage,
        this.image,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    summary = json['summary'];
    policyCategory = json['policyCategory'];
    link = json['link'];
    thumbImage = json['thumbImage'];
    image = json['image'].cast<String>();
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['policyCategory'] = this.policyCategory;
    data['link'] = this.link;
    data['thumbImage'] = this.thumbImage;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}