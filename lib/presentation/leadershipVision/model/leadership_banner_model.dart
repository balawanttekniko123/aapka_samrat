class LeadershipBannerModel {
  bool? status;
  String? message;
  List<LeadershipBannerData>? data;

  LeadershipBannerModel({this.status, this.message, this.data});

  LeadershipBannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LeadershipBannerData>[];
      json['data'].forEach((v) {
        data!.add(new LeadershipBannerData.fromJson(v));
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

class LeadershipBannerData {
  String? sId;
  String? title;
  List<String>? image;
  int? priority;
  String? category;
  bool? status;
  String? createdAt;
  int? iV;

  LeadershipBannerData(
      {this.sId,
        this.title,
        this.image,
        this.priority,
        this.category,
        this.status,
        this.createdAt,
        this.iV});

  LeadershipBannerData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    image = json['image'].cast<String>();
    priority = json['priority'];
    category = json['category'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['priority'] = this.priority;
    data['category'] = this.category;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
