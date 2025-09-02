// class SchemeModel {
//   bool? status;
//   String? message;
//   List<Data>? data;
//
//   SchemeModel({this.status, this.message, this.data});
//
//   SchemeModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? sId;
//   String? title;
//   String? summary;
//   SchemeCategory? schemeCategory;
//   String? department;
//   String? government;
//   String? link;
//   String? thumbImage;
//   List<String>? image;
//   String? createdAt;
//   int? iV;
//
//   Data(
//       {this.sId,
//         this.title,
//         this.summary,
//         this.schemeCategory,
//         this.department,
//         this.government,
//         this.link,
//         this.thumbImage,
//         this.image,
//         this.createdAt,
//         this.iV});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     summary = json['summary'];
//     schemeCategory = json['schemeCategory'] != null
//         ? new SchemeCategory.fromJson(json['schemeCategory'])
//         : null;
//     department = json['department'];
//     government = json['government'];
//     link = json['link'];
//     thumbImage = json['thumbImage'];
//     image = json['image'].cast<String>();
//     createdAt = json['createdAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['title'] = this.title;
//     data['summary'] = this.summary;
//     if (this.schemeCategory != null) {
//       data['schemeCategory'] = this.schemeCategory!.toJson();
//     }
//     data['department'] = this.department;
//     data['government'] = this.government;
//     data['link'] = this.link;
//     data['thumbImage'] = this.thumbImage;
//     data['image'] = this.image;
//     data['createdAt'] = this.createdAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }
//
// class SchemeCategory {
//   String? sId;
//   String? name;
//
//   SchemeCategory({this.sId, this.name});
//
//   SchemeCategory.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     return data;
//   }
// }
class SchemeModel {
  bool? status;
  String? message;
  List<Data>? data;
  
  

  SchemeModel({this.status, this.message, this.data});
  
  

  SchemeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
  
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  List<SchemeCategory>? schemeCategory; // Changed to List<SchemeCategory>
  String? department;
  String? government;
  String? link;
  String? thumbImage;
  List<String>? image;
  String? createdAt;
  int? iV;
  
  

  Data({
    this.sId,
    this.title,
    this.summary,
    this.schemeCategory,
    this.department,
    this.government,
    this.link,
    this.thumbImage,
    this.image,
    this.createdAt,
    this.iV,
  });
  
  

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    summary = json['summary'];
    if (json['schemeCategory'] != null) {
      schemeCategory = <SchemeCategory>[];
      json['schemeCategory'].forEach((v) {
        schemeCategory!.add(SchemeCategory.fromJson(v));
      });
    }
    department = json['department'];
    government = json['government'];
    link = json['link'];
    thumbImage = json['thumbImage'];
    image = json['image'] != null ? List<String>.from(json['image']) : null; // Handle as List<String>
    createdAt = json['createdAt'];
    iV = json['__v'];
  }
  
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['summary'] = this.summary;
    if (this.schemeCategory != null) {
      data['schemeCategory'] = this.schemeCategory!.map((v) => v.toJson()).toList();
    }
    data['department'] = this.department;
    data['government'] = this.government;
    data['link'] = this.link;
    data['thumbImage'] = this.thumbImage;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}



class SchemeCategory {
  String? sId;
  String? name;
  
  

  SchemeCategory({this.sId, this.name});
  
  

  SchemeCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }
  
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}