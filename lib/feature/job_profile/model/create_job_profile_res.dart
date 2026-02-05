class CreateJobProfileRes {
  CreateJobProfileData? data;

  CreateJobProfileRes({this.data});

  CreateJobProfileRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CreateJobProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CreateJobProfileData {
  InsertJobProfiles? insertJobProfiles;

  CreateJobProfileData({this.insertJobProfiles});

  CreateJobProfileData.fromJson(Map<String, dynamic> json) {
    insertJobProfiles = json['insert_job_profiles'] != null
        ? new InsertJobProfiles.fromJson(json['insert_job_profiles'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.insertJobProfiles != null) {
      data['insert_job_profiles'] = this.insertJobProfiles!.toJson();
    }
    return data;
  }
}

class InsertJobProfiles {
  int? affectedRows;
  String? sTypename;

  InsertJobProfiles({this.affectedRows, this.sTypename});

  InsertJobProfiles.fromJson(Map<String, dynamic> json) {
    affectedRows = json['affected_rows'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['affected_rows'] = this.affectedRows;
    data['__typename'] = this.sTypename;
    return data;
  }
}
