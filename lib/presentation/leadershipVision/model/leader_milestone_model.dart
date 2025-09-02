class LeadershipMileStoneModel {
  bool? status;
  String? message;
  List<Data>? data;

  LeadershipMileStoneModel({this.status, this.message, this.data});

  LeadershipMileStoneModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? summary;
  String? year;
  String? category;
  String? createdAt;
  int? iV;

  Data(
      {this.sId,
        this.title,
        this.summary,
        this.year,
        this.category,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    summary = json['summary'];
    year = json['year'];
    category = json['category'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['year'] = this.year;
    data['category'] = this.category;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
