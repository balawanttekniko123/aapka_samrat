// class SubDirectoryModel {
//   bool? status;
//   String? message;
//   List<Data>? data;
//
//   SubDirectoryModel({this.status, this.message, this.data});
//
//   SubDirectoryModel.fromJson(Map<String, dynamic> json) {
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
//   String? degignation;
//   String? number;
//   String? email;
//   DirectoryCategory? directoryCategory;
//   District? district;
//   DirectoryCategory? subDirectoryCategory;
//   String? fax;
//   String? landline;
//   String? createdAt;
//   int? iV;
//
//   Data(
//       {this.sId,
//         this.degignation,
//         this.number,
//         this.email,
//         this.directoryCategory,
//         this.district,
//         this.subDirectoryCategory,
//         this.fax,
//         this.landline,
//         this.createdAt,
//         this.iV});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     degignation = json['degignation'];
//     number = json['number'];
//     email = json['email'];
//     directoryCategory = json['directoryCategory'] != null
//         ? new DirectoryCategory.fromJson(json['directoryCategory'])
//         : null;
//     district = json['district'] != null
//         ? new District.fromJson(json['district'])
//         : null;
//     subDirectoryCategory = json['subDirectoryCategory'] != null
//         ? new DirectoryCategory.fromJson(json['subDirectoryCategory'])
//         : null;
//     fax = json['fax'];
//     landline = json['landline'];
//     createdAt = json['createdAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['degignation'] = this.degignation;
//     data['number'] = this.number;
//     data['email'] = this.email;
//     if (this.directoryCategory != null) {
//       data['directoryCategory'] = this.directoryCategory!.toJson();
//     }
//     if (this.district != null) {
//       data['district'] = this.district!.toJson();
//     }
//     if (this.subDirectoryCategory != null) {
//       data['subDirectoryCategory'] = this.subDirectoryCategory!.toJson();
//     }
//     data['fax'] = this.fax;
//     data['landline'] = this.landline;
//     data['createdAt'] = this.createdAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }
//
// class DirectoryCategory {
//   String? sId;
//   String? name;
//
//   DirectoryCategory({this.sId, this.name});
//
//   DirectoryCategory.fromJson(Map<String, dynamic> json) {
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
//
// class District {
//   String? sId;
//   String? districtName;
//
//   District({this.sId, this.districtName});
//
//   District.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     districtName = json['districtName'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['districtName'] = this.districtName;
//     return data;
//   }
// }

class SubDirectoryModel {
  bool? status;
  String? message;
  List<Data>? data;

  SubDirectoryModel({this.status, this.message, this.data});

  SubDirectoryModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  DirectoryCategory? directoryCategory;
  String? createdAt;
  int? iV;
  String? district;

  Data(
      {this.sId,
        this.name,
        this.directoryCategory,
        this.createdAt,
        this.iV,
        this.district});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    directoryCategory = json['directoryCategory'] != null
        ? new DirectoryCategory.fromJson(json['directoryCategory'])
        : null;
    createdAt = json['createdAt'];
    iV = json['__v'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.directoryCategory != null) {
      data['directoryCategory'] = this.directoryCategory!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['district'] = this.district;
    return data;
  }
}

class DirectoryCategory {
  String? sId;
  String? name;

  DirectoryCategory({this.sId, this.name});

  DirectoryCategory.fromJson(Map<String, dynamic> json) {
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

// class SubDirectoryModel {
//   bool? status;
//   String? message;
//   List<Data>? data;
//
//   SubDirectoryModel({this.status, this.message, this.data});
//
//   SubDirectoryModel.fromJson(Map<String, dynamic> json) {
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
//   String? name;
//   DirectoryCategory? directoryCategory;
//   District? district;
//   String? createdAt;
//   int? iV;
//
//   Data(
//       {this.sId,
//         this.name,
//         this.directoryCategory,
//         this.district,
//         this.createdAt,
//         this.iV});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     directoryCategory = json['directoryCategory'] != null
//         ? new DirectoryCategory.fromJson(json['directoryCategory'])
//         : null;
//     district = json['district'] != null
//         ? new District.fromJson(json['district'])
//         : null;
//     createdAt = json['createdAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     if (this.directoryCategory != null) {
//       data['directoryCategory'] = this.directoryCategory!.toJson();
//     }
//     if (this.district != null) {
//       data['district'] = this.district!.toJson();
//     }
//     data['createdAt'] = this.createdAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }
//
// class DirectoryCategory {
//   String? sId;
//   String? name;
//
//   DirectoryCategory({this.sId, this.name});
//
//   DirectoryCategory.fromJson(Map<String, dynamic> json) {
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
//
// class District {
//   String? sId;
//   String? districtName;
//
//   District({this.sId, this.districtName});
//
//   District.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     districtName = json['districtName'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['districtName'] = this.districtName;
//     return data;
//   }
// }