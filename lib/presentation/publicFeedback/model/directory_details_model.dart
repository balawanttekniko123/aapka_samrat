class DirectoryResponse {
  final bool status;
  final String message;
  final List<DirectoryData> data;

  DirectoryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DirectoryResponse.fromJson(Map<String, dynamic> json) {
    return DirectoryResponse(
      status: json['status'],
      message: json['message'],
      data: List<DirectoryData>.from(
        json['data'].map((item) => DirectoryData.fromJson(item)),
      ),
    );
  }
}

class DirectoryData {
  final String id;
  final String degignation;
  final String number;
  final String email;
  final DirectoryCategory directoryCategory;
  final District district;
  final DateTime createdAt;

  DirectoryData({
    required this.id,
    required this.degignation,
    required this.number,
    required this.email,
    required this.directoryCategory,
    required this.district,
    required this.createdAt,
  });

  factory DirectoryData.fromJson(Map<String, dynamic> json) {
    return DirectoryData(
      id: json['_id'],
      degignation: json['degignation'],
      number: json['number'],
      email: json['email'],
      directoryCategory: DirectoryCategory.fromJson(json['directoryCategory']),
      district: District.fromJson(json['district']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class DirectoryCategory {
  final String id;
  final String name;

  DirectoryCategory({
    required this.id,
    required this.name,
  });

  factory DirectoryCategory.fromJson(Map<String, dynamic> json) {
    return DirectoryCategory(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class District {
  final String id;
  final String districtName;

  District({
    required this.id,
    required this.districtName,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['_id'],
      districtName: json['districtName'],
    );
  }
}
