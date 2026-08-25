class JobsRoleListRes {
  JobRoleData? data;

  JobsRoleListRes({this.data});

  JobsRoleListRes.fromJson(Map<String, dynamic> json) {
    final responseData = json['data'];

    if (responseData is Map) {
      data = JobRoleData.fromJson(
        Map<String, dynamic>.from(responseData),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    return data;
  }
}

class JobRoleData {
  List<JobsRoleList>? jobsRoleList;

  JobRoleData({this.jobsRoleList});

  JobRoleData.fromJson(Map<String, dynamic> json) {
    final roles = json['jobs_role_list'];

    if (roles is List) {
      jobsRoleList = roles
          .whereType<Map>()
          .map(
            (v) => JobsRoleList.fromJson(
              Map<String, dynamic>.from(v),
            ),
          )
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (jobsRoleList != null) {
      data['jobs_role_list'] =
          jobsRoleList!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class JobsRoleList {
  String? id;
  String? roleName;
  String? sTypename;

  JobsRoleList({
    this.id,
    this.roleName,
    this.sTypename,
  });

  JobsRoleList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    roleName = json['role_name']?.toString();
    sTypename = json['__typename']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role_name': roleName,
      '__typename': sTypename,
    };
  }
}