class JobProfileRoleResponse {
  JobProfileRoleData? data;

  JobProfileRoleResponse({this.data});

  JobProfileRoleResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new  JobProfileRoleData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class   JobProfileRoleData{
  List<JobsRoleLists>? jobsRoleList;

  JobProfileRoleData({this.jobsRoleList});

  JobProfileRoleData.fromJson(Map<String, dynamic> json) {
    if (json['jobs_role_list'] != null) {
      jobsRoleList = <JobsRoleLists>[];
      json['jobs_role_list'].forEach((v) {
        jobsRoleList!.add(new JobsRoleLists.fromJson(v));
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

class JobsRoleLists {
  String? id;
  String? roleName;
  String? createdAt;

  JobsRoleLists({this.id, this.roleName, this.createdAt});

  JobsRoleLists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleName = json['role_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_name'] = this.roleName;
    data['created_at'] = this.createdAt;
    return data;
  }
}
