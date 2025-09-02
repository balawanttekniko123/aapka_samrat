class DistrictDetailModel {
  bool? status;
  String? message;
  Data? data;

  DistrictDetailModel({this.status, this.message, this.data});

  DistrictDetailModel.fromJson(Map<String, dynamic> json) {
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
  District? district;
  List<Superidentents>? superidentents;//todo
  List<Magistrates>? magistrates;//todo
  int? hospitalCount;
  int? bankCount;
  int? postalCount;
  int? electrictyCount;
  int? collegeCount;
  int? municipalityCount;
  int? ngoCount;
  int? schoolCount;

  Data(
      {this.district,
        this.superidentents,
        this.magistrates,
        this.hospitalCount,
        this.bankCount,
        this.postalCount,
        this.electrictyCount,
        this.collegeCount,
        this.municipalityCount,
        this.ngoCount,
        this.schoolCount});

  Data.fromJson(Map<String, dynamic> json) {
    district = json['district'] != null
        ? new District.fromJson(json['district'])
        : null;
    if (json['superidentents'] != null) {
      superidentents = <Superidentents>[];
      json['superidentents'].forEach((v) {
        superidentents!.add(new Superidentents.fromJson(v));
      });
    }
    if (json['magistrates'] != null) {
      magistrates = <Magistrates>[];
      json['magistrates'].forEach((v) {
        magistrates!.add(new Magistrates.fromJson(v));
      });
    }
    // magistrates = json['magistrates'].cast<String>();
    hospitalCount = json['hospitalCount'];
    bankCount = json['bankCount'];
    postalCount = json['postalCount'];
    electrictyCount = json['electrictyCount'];
    collegeCount = json['collegeCount'];
    municipalityCount = json['municipalityCount'];
    ngoCount = json['ngoCount'];
    schoolCount = json['schoolCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    if (this.superidentents != null) {
      data['superidentents'] =
          this.superidentents!.map((v) => v.toJson()).toList();
    }
    if (this.magistrates != null) {
      data['magistrates'] =
          this.magistrates!.map((v) => v.toJson()).toList();
    }
    // data['magistrates'] = this.magistrates;
    data['hospitalCount'] = this.hospitalCount;
    data['bankCount'] = this.bankCount;
    data['postalCount'] = this.postalCount;
    data['electrictyCount'] = this.electrictyCount;
    data['collegeCount'] = this.collegeCount;
    data['municipalityCount'] = this.municipalityCount;
    data['ngoCount'] = this.ngoCount;
    data['schoolCount'] = this.schoolCount;
    return data;
  }
}

class District {
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

  District(
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

  District.fromJson(Map<String, dynamic> json) {
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

class Superidentents {
  String? sId;
  String? name;
  String? mobile;
  String? profileImage;
  String? linkdin;
  String? workingStartDate;
  String? workingEndDate;
  String? twitter;
  bool? isWorking;
  String? district;
  String? createdAt;
  int? iV;

  Superidentents(
      {this.sId,
        this.name,
        this.mobile,
        this.profileImage,
        this.linkdin,
        this.workingStartDate,
        this.workingEndDate,
        this.twitter,
        this.isWorking,
        this.district,
        this.createdAt,
        this.iV});

  Superidentents.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    mobile = json['mobile'];
    profileImage = json['profileImage'];
    linkdin = json['linkdin'];
    workingStartDate = json['workingStartDate'];
    workingEndDate = json['workingEndDate'];
    twitter = json['twitter'];
    isWorking = json['isWorking'];
    district = json['district'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['profileImage'] = this.profileImage;
    data['linkdin'] = this.linkdin;
    data['workingStartDate'] = this.workingStartDate;
    data['workingEndDate'] = this.workingEndDate;
    data['twitter'] = this.twitter;
    data['isWorking'] = this.isWorking;
    data['district'] = this.district;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
class Magistrates {
  String? sId;
  String? name;
  String? mobile;
  String? profileImage;
  String? linkdin;
  String? workingStartDate;
  String? workingEndDate;
  String? twitter;
  bool? isWorking;
  String? district;
  String? createdAt;
  int? iV;

  Magistrates(
      {this.sId,
        this.name,
        this.mobile,
        this.profileImage,
        this.linkdin,
        this.workingStartDate,
        this.workingEndDate,
        this.twitter,
        this.isWorking,
        this.district,
        this.createdAt,
        this.iV});

  Magistrates.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    mobile = json['mobile'];
    profileImage = json['profileImage'];
    linkdin = json['linkdin'];
    workingStartDate = json['workingStartDate'];
    workingEndDate = json['workingEndDate'];
    twitter = json['twitter'];
    isWorking = json['isWorking'];
    district = json['district'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['profileImage'] = this.profileImage;
    data['linkdin'] = this.linkdin;
    data['workingStartDate'] = this.workingStartDate;
    data['workingEndDate'] = this.workingEndDate;
    data['twitter'] = this.twitter;
    data['isWorking'] = this.isWorking;
    data['district'] = this.district;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}