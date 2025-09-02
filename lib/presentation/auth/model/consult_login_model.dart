class LoginModel {
  bool? status;
  String? message;
  LoginData? data;
  bool? newUser;

  LoginModel({this.status, this.message, this.data, this.newUser});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    newUser = json['newUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['newUser'] = this.newUser;
    return data;
  }
}

class LoginData {
  String? mobile;
  String? email;
  String? otpExpiry;
  User? user;
  String? type;

  LoginData({this.mobile, this.email, this.otpExpiry, this.user, this.type});

  LoginData.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    email = json['email'];
    otpExpiry = json['otpExpiry'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['otpExpiry'] = this.otpExpiry;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['type'] = this.type;
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
  String? otpExpiry;

  User(
      {this.sId,
        this.email,
        this.mobile,
        this.profileImage,
        this.state,
        this.createdAt,
        this.iV,
        this.otpExpiry});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    mobile = json['mobile'];
    profileImage = json['profileImage'];
    state = json['state'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    otpExpiry = json['otpExpiry'];
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
    data['otpExpiry'] = this.otpExpiry;
    return data;
  }
}
