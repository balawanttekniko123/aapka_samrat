class NotificationModel {
  bool? status;
  int? totalPage;
  int? totalResult;
  int? results;
  List<Data>? data;

  NotificationModel(
      {this.status, this.totalPage, this.totalResult, this.results, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalPage = json['totalPage'];
    totalResult = json['totalResult'];
    results = json['results'];
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
    data['totalPage'] = this.totalPage;
    data['totalResult'] = this.totalResult;
    data['results'] = this.results;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? message;
  String? image;
  Null? userId;
  String? createdAt;
  int? iV;
  String? id;

  Data(
      {this.sId,
        this.title,
        this.message,
        this.image,
        this.userId,
        this.createdAt,
        this.iV,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    message = json['message'];
    image = json['image'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['image'] = this.image;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
}