// class AllSchemeCategoryWiseModel {
//   bool? status;
//   String? message;
//   List<Data>? data;
//
//   AllSchemeCategoryWiseModel({this.status, this.message, this.data});
//
//   AllSchemeCategoryWiseModel.fromJson(Map<String, dynamic> json) {
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
//   String? categoryName;
//   List<Schemes>? schemes;
//
//   Data({this.sId, this.categoryName, this.schemes});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     categoryName = json['categoryName'];
//     if (json['schemes'] != null) {
//       schemes = <Schemes>[];
//       json['schemes'].forEach((v) {
//         schemes!.add(new Schemes.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['categoryName'] = this.categoryName;
//     if (this.schemes != null) {
//       data['schemes'] = this.schemes!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Schemes {
//   String? sId;
//   String? title;
//   String? summary;
//   String? schemeCategory;
//   String? department;
//   String? government;
//   String? link;
//   String? thumbImage;
//   List<String>? image;
//   String? createdAt;
//   int? iV;
//   CategoryDetails? categoryDetails;
//
//   Schemes(
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
//         this.iV,
//         this.categoryDetails});
//
//   Schemes.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     summary = json['summary'];
//     schemeCategory = json['schemeCategory'];
//     department = json['department'];
//     government = json['government'];
//     link = json['link'];
//     thumbImage = json['thumbImage'];
//     image = json['image'].cast<String>();
//     createdAt = json['createdAt'];
//     iV = json['__v'];
//     categoryDetails = json['categoryDetails'] != null
//         ? new CategoryDetails.fromJson(json['categoryDetails'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['title'] = this.title;
//     data['summary'] = this.summary;
//     data['schemeCategory'] = this.schemeCategory;
//     data['department'] = this.department;
//     data['government'] = this.government;
//     data['link'] = this.link;
//     data['thumbImage'] = this.thumbImage;
//     data['image'] = this.image;
//     data['createdAt'] = this.createdAt;
//     data['__v'] = this.iV;
//     if (this.categoryDetails != null) {
//       data['categoryDetails'] = this.categoryDetails!.toJson();
//     }
//     return data;
//   }
// }
//
// class CategoryDetails {
//   String? sId;
//   String? name;
//   String? thumbImage;
//   String? department;
//   String? government;
//   bool? status;
//   String? createdAt;
//   int? iV;
//
//   CategoryDetails(
//       {this.sId,
//         this.name,
//         this.thumbImage,
//         this.department,
//         this.government,
//         this.status,
//         this.createdAt,
//         this.iV});
//
//   CategoryDetails.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     thumbImage = json['thumbImage'];
//     department = json['department'];
//     government = json['government'];
//     status = json['status'];
//     createdAt = json['createdAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['thumbImage'] = this.thumbImage;
//     data['department'] = this.department;
//     data['government'] = this.government;
//     data['status'] = this.status;
//     data['createdAt'] = this.createdAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }
class AllSchemeCategoryWiseModel {
  bool? status;
  String? message;
  List<Data>? data;
  
  

  AllSchemeCategoryWiseModel({this.status, this.message, this.data});
  
  

  AllSchemeCategoryWiseModel.fromJson(Map<String, dynamic> json) {
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
  String? categoryName;
  List<Schemes>? schemes;
  
  

  Data({this.sId, this.categoryName, this.schemes});
  
  

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['categoryName'];
    if (json['schemes'] != null) {
      schemes = <Schemes>[];
      json['schemes'].forEach((v) {
        schemes!.add(Schemes.fromJson(v));
      });
    }
  }
  
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['categoryName'] = this.categoryName;
    if (this.schemes != null) {
      data['schemes'] = this.schemes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Schemes {
  String? sId;
  String? title;
  String? summary;
  List<String>? schemeCategory; // Changed to List<String>
  String? department;
  String? government;
  String? link;
  String? thumbImage;
  List<String>? image;
  String? createdAt;
  int? iV;
  CategoryDetails? categoryDetails;
  
  

  Schemes({
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
    this.categoryDetails,
  });


  Schemes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    summary = json['summary'];
    schemeCategory = json['schemeCategory'] != null ? List<String>.from(json['schemeCategory']) : null; // Handle as List<String>
    department = json['department'];
    government = json['government'];
    link = json['link'];
    thumbImage = json['thumbImage'];
    image = json['image'] != null ? List<String>.from(json['image']) : null; // Handle as List<String>
    createdAt = json['createdAt'];
    iV = json['__v'];
    categoryDetails = json['categoryDetails'] != null
        ? CategoryDetails.fromJson(json['categoryDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['schemeCategory'] = this.schemeCategory; // No need to convert to List
    data['department'] = this.department;
    data['government'] = this.government;
    data['link'] = this.link;
    data['thumbImage'] = this.thumbImage;
    data['image'] = this.image; // No need to convert to List
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    if (this.categoryDetails != null) {
      data['categoryDetails'] = this.categoryDetails!.toJson();
    }
    return data;
  }
}


class CategoryDetails {
  String? sId;
  String? name;
  String? thumbImage;
  String? department;
  String? government;
  bool? status;
  String? createdAt;
  int? iV;

 

  CategoryDetails({
    this.sId,
    this.name,
    this.thumbImage,
    this.department,
    this.government,
    this.status,
    this.createdAt,
    this.iV,
  });


  CategoryDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    thumbImage = json['thumbImage'];
    department = json['department'];
    government = json['government'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['thumbImage'] = this.thumbImage;
    data['department'] = this.department;
    data['government'] = this.government;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}