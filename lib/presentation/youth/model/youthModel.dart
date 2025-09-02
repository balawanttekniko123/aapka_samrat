class YouthModel {
  bool? status;
  String? message;
  List<Data>? data;

  YouthModel({this.status, this.message, this.data});

  YouthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  List<String>? image;
  String? summary;
  String? createdAt;
  int? iV;

  Data({this.sId, this.image, this.summary, this.createdAt, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'].cast<String>();
    summary = json['summary'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['image'] = this.image;
    data['summary'] = this.summary;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}