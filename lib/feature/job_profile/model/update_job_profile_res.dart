class UpdateJobProfileRes {
  UpdateJobProfileData? data;

  UpdateJobProfileRes({this.data});

  UpdateJobProfileRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UpdateJobProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UpdateJobProfileData {
  UpdateJobProfilesByPk? updateJobProfilesByPk;

  UpdateJobProfileData({this.updateJobProfilesByPk});

  UpdateJobProfileData.fromJson(Map<String, dynamic> json) {
    updateJobProfilesByPk = json['update_job_profiles_by_pk'] != null
        ? new UpdateJobProfilesByPk.fromJson(json['update_job_profiles_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.updateJobProfilesByPk != null) {
      data['update_job_profiles_by_pk'] = this.updateJobProfilesByPk!.toJson();
    }
    return data;
  }
}

class UpdateJobProfilesByPk {
  String? id;
  String? sTypename;

  UpdateJobProfilesByPk({this.id, this.sTypename});

  UpdateJobProfilesByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['__typename'] = this.sTypename;
    return data;
  }
}
