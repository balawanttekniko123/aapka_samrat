class EditProfileModel {
  bool? status;
  var message;
  Data? data;

  EditProfileModel({this.status, this.message, this.data});

  EditProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  var district;
  var sId;
  var email;
  var mobile;
  var profileImage;
  var state;
  var createdAt;
  var iV;
  var otpExpiry;
  var city;
  var name;

  Data(
      {this.district,
        this.sId,
        this.email,
        this.mobile,
        this.profileImage,
        this.state,
        this.createdAt,
        this.iV,
        this.otpExpiry,
        this.city,
        this.name});

  Data.fromJson(Map<String, dynamic> json) {
    district = json['district'];
    sId = json['_id'];
    email = json['email'];
    mobile = json['mobile'];
    profileImage = json['profileImage'];
    state = json['state'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    otpExpiry = json['otpExpiry'];
    city = json['city'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district'] = this.district;
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profileImage'] = this.profileImage;
    data['state'] = this.state;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['otpExpiry'] = this.otpExpiry;
    data['city'] = this.city;
    data['name'] = this.name;
    return data;
  }
}