class JobSeekFilterProfessionModel {
  Data? data;

  JobSeekFilterProfessionModel({this.data});

  JobSeekFilterProfessionModel.fromJson(Map<String, dynamic> json) {
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
  List<JobsRoleList>? jobsRoleList;

  Data({this.jobsRoleList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['jobs_role_list'] != null) {
      jobsRoleList = <JobsRoleList>[];
      json['jobs_role_list'].forEach((v) {
        jobsRoleList!.add(new JobsRoleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobsRoleList != null) {
      data['jobs_role_list'] =
          this.jobsRoleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobsRoleList {
  String? id;
  String? roleName;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? createdByUserId;
  String? sTypename;

  JobsRoleList(
      {this.id,
      this.roleName,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.createdByUserId,
      this.sTypename});

  JobsRoleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleName = json['role_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    createdByUserId = json['created_by_user_id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_name'] = this.roleName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['created_by_user_id'] = this.createdByUserId;
    data['__typename'] = this.sTypename;
    return data;
  }
}
