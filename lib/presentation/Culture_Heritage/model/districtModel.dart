class DistrictListModel {
  bool? status;
  String? message;
  List<Data>? data;

  DistrictListModel({this.status, this.message, this.data});

  DistrictListModel.fromJson(Map<String, dynamic> json) {
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
  String? districtName;
  String? about;
  String? area;
  String? populateion;
  String? literacyRate;
  String? block;
  String? village;
  String? muncipality;
  String? policeStation;
  String? language;
  String? hospital;
  String? bank;
  String? postal;
  String? electricty;
  String? college;
  String? ngo;
  String? school;
  int? iV;

  Data(
      {this.sId,
        this.districtName,
        this.about,
        this.area,
        this.populateion,
        this.literacyRate,
        this.block,
        this.village,
        this.muncipality,
        this.policeStation,
        this.language,
        this.hospital,
        this.bank,
        this.postal,
        this.electricty,
        this.college,
        this.ngo,
        this.school,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    districtName = json['districtName'];
    about = json['about'];
    area = json['area'];
    populateion = json['populateion'];
    literacyRate = json['literacyRate'];
    block = json['block'];
    village = json['village'];
    muncipality = json['muncipality'];
    policeStation = json['policeStation'];
    language = json['language'];
    hospital = json['hospital'];
    bank = json['bank'];
    postal = json['postal'];
    electricty = json['electricty'];
    college = json['college'];
    ngo = json['ngo'];
    school = json['school'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['districtName'] = this.districtName;
    data['about'] = this.about;
    data['area'] = this.area;
    data['populateion'] = this.populateion;
    data['literacyRate'] = this.literacyRate;
    data['block'] = this.block;
    data['village'] = this.village;
    data['muncipality'] = this.muncipality;
    data['policeStation'] = this.policeStation;
    data['language'] = this.language;
    data['hospital'] = this.hospital;
    data['bank'] = this.bank;
    data['postal'] = this.postal;
    data['electricty'] = this.electricty;
    data['college'] = this.college;
    data['ngo'] = this.ngo;
    data['school'] = this.school;
    data['__v'] = this.iV;
    return data;
  }
}