class RoadMapModel {
  bool? status;
  String? message;
  List<Data>? data;

  RoadMapModel({this.status, this.message, this.data});

  RoadMapModel.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? thumbImage;
  String? createdAt;
  int? iV;

  Data({this.sId, this.description, this.thumbImage, this.createdAt, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    thumbImage = json['thumbImage'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['thumbImage'] = this.thumbImage;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
