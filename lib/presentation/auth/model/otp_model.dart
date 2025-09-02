class OtpVerifyModel {
  bool? status;
  String? message;
  String? token;
  Data? data;

  OtpVerifyModel({this.status, this.message, this.token, this.data});

  OtpVerifyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? email;
  String? mobile;
  String? profileImage;
  String? state;
  String? createdAt;
  int? iV;

  User(
      {this.sId,
        this.email,
        this.mobile,
        this.profileImage,
        this.state,
        this.createdAt,
        this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    mobile = json['mobile'];
    profileImage = json['profileImage'];
    state = json['state'];
    createdAt = json['createdAt'];
    iV = json['__v'];
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
    return data;
  }
}
