class JobSeekFilterWorktypeModel {
  Data? data;

  JobSeekFilterWorktypeModel({this.data});

  JobSeekFilterWorktypeModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<JobTypes>? jobTypes;

  Data({this.jobTypes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['job_types'] != null) {
      jobTypes = <JobTypes>[];
      json['job_types'].forEach((v) {
        jobTypes!.add(new JobTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobTypes != null) {
      data['job_types'] = this.jobTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobTypes {
  String? id;
  String? employeeTypeName;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? createdByUserId;
  String? sTypename;

  JobTypes(
      {this.id,
      this.employeeTypeName,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.createdByUserId,
      this.sTypename});

  JobTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeTypeName = json['employee_type_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    createdByUserId = json['created_by_user_id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_type_name'] = this.employeeTypeName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['created_by_user_id'] = this.createdByUserId;
    data['__typename'] = this.sTypename;
    return data;
  }
}
