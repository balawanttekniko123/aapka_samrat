class CMSModel {
  bool? success;
  String? message;
  List<Data>? data;

  CMSModel({this.success, this.message, this.data});

  CMSModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
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
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  int? iV;
  String? createdAt;
  List<Faq>? faq;
  String? privacyPolicy;
  String? termCondition;
  String? aboutUs;

  Data(
      {this.sId,
        this.iV,
        this.createdAt,
        this.faq,
        this.privacyPolicy,
        this.termCondition,
        this.aboutUs});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    if (json['faq'] != null) {
      faq = <Faq>[];
      json['faq'].forEach((v) {
        faq!.add(new Faq.fromJson(v));
      });
    }
    privacyPolicy = json['privacyPolicy'];
    termCondition = json['termCondition'];
    aboutUs = json['aboutUs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    if (this.faq != null) {
      data['faq'] = this.faq!.map((v) => v.toJson()).toList();
    }
    data['privacyPolicy'] = this.privacyPolicy;
    data['termCondition'] = this.termCondition;
    data['aboutUs'] = this.aboutUs;
    return data;
  }
}

class Faq {
  String? question;
  String? answer;
  String? sId;

  Faq({this.question, this.answer, this.sId});

  Faq.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['_id'] = this.sId;
    return data;
  }
}