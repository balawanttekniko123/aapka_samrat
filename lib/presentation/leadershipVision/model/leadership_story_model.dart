class LeadershipStoryModel {
  bool? status;
  String? message;
  List<LeadershipStoryData>? data;

  LeadershipStoryModel({this.status, this.message, this.data});

  LeadershipStoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LeadershipStoryData>[];
      json['data'].forEach((v) {
        data!.add(new LeadershipStoryData.fromJson(v));
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

class LeadershipStoryData {
  String? sId;
  String? thumbImage;
  List<String>? image;
  List<String>? video;
  Category? category;
  String? createdAt;
  String? title;
  int? iV;

  LeadershipStoryData(
      {this.sId,
        this.thumbImage,
        this.image,
        this.video,
        this.category,
        this.title,
        this.createdAt,
        this.iV});

  LeadershipStoryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    thumbImage = json['thumbImage'];
    image = json['image'].cast<String>();
    video = json['video'].cast<String>();
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['thumbImage'] = this.thumbImage;
    data['image'] = this.image;
    data['video'] = this.video;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Category {
  String? sId;
  String? name;

  Category({this.sId, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
