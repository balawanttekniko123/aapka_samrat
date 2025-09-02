class HomeSelectedModel {
  bool? status;
  String? message;
  List<HomeCategoryData>? data;

  HomeSelectedModel({this.status, this.message, this.data});

  HomeSelectedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HomeCategoryData>[];
      json['data'].forEach((v) {
        data!.add(new HomeCategoryData.fromJson(v));
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

class HomeCategoryData {
  String? sId;
  String? name;
  String? image;
  String? createdAt;
  int? iV;
  int? priority;

  HomeCategoryData(
      {this.sId,
        this.name,
        this.image,
        this.createdAt,
        this.iV,
        this.priority});

  HomeCategoryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['priority'] = this.priority;
    return data;
  }
}
