class ProfileModel {
  bool? success;
  String? message;
  Data? data;

  ProfileModel({this.success, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? email;
  String? mobile;
  String? profileImage;
  String? state;
  String? createdAt;
  int? iV;
  String? city;
  String? district;
  String? name;

  Data(
      {this.sId,
        this.email,
        this.mobile,
        this.profileImage,
        this.state,
        this.createdAt,
        this.iV,
        this.city,
        this.district,
        this.name});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    mobile = json['mobile'];
    profileImage = json['profileImage'];
    state = json['state'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    city = json['city'];
    district = json['district'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profileImage'] = this.profileImage;
    data['state'] = this.state;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['city'] = this.city;
    data['district'] = this.district;
    data['name'] = this.name;
    return data;
  }
}