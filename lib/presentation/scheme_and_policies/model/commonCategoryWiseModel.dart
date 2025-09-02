class CommonSchemeCategoryWiseModel {
  bool? status;
  String? message;
  List<SchemeData>? data;

  CommonSchemeCategoryWiseModel({this.status, this.message, this.data});

  CommonSchemeCategoryWiseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SchemeData>[];
      json['data'].forEach((v) {
        data!.add(SchemeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SchemeData {
  String? sId;
  String? title;
  String? summary;
  List<String>? schemeCategory;
  String? department;
  String? government;
  String? link;
  List<dynamic>? image; // Since image is an empty list, assume it can contain dynamic content
  String? createdAt;
  int? iV;

  SchemeData({
    this.sId,
    this.title,
    this.summary,
    this.schemeCategory,
    this.department,
    this.government,
    this.link,
    this.image,
    this.createdAt,
    this.iV,
  });

  SchemeData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    summary = json['summary'];
    schemeCategory = json['schemeCategory'] != null
        ? List<String>.from(json['schemeCategory'])
        : [];
    department = json['department'];
    government = json['government'];
    link = json['link'];
    image = json['image'] != null ? List<dynamic>.from(json['image']) : [];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['_id'] = sId;
    map['title'] = title;
    map['summary'] = summary;
    map['schemeCategory'] = schemeCategory;
    map['department'] = department;
    map['government'] = government;
    map['link'] = link;
    map['image'] = image;
    map['createdAt'] = createdAt;
    map['__v'] = iV;
    return map;
  }
}
