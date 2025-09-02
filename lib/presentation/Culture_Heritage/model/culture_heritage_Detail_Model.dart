class CultureHeritagDetailModel {
  bool? success;
  var message;
  Data? data;

  CultureHeritagDetailModel({this.success, this.message, this.data});

  CultureHeritagDetailModel.fromJson(Map<String, dynamic> json) {
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
  var sId;
  var name;
  var description;
  List<String>? image;
  var district;
  var address;
  var createdAt;
  var lat;
  var log;
  var updatedAt;
  var iV;

  Data(
      {this.sId,
        this.name,
        this.description,
        this.image,
        this.district,
        this.address,
        this.createdAt,
        this.lat,
        this.log,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'].cast<String>();
    district = json['district'];
    address = json['address'];
    createdAt = json['createdAt'];
    lat = json['lat'];
    log = json['log'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['district'] = this.district;
    data['address'] = this.address;
    data['createdAt'] = this.createdAt;
    data['log'] = this.log;
    data['lat'] = this.lat;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}