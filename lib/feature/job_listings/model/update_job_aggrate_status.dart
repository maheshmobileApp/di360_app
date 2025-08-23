class UpadateJobAggrateStatusResp {
  JobapplientStatus? data;

  UpadateJobAggrateStatusResp({this.data});

  UpadateJobAggrateStatusResp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new JobapplientStatus.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class JobapplientStatus {
  UpdateJobApplicantsByPk? updateJobApplicantsByPk;

  JobapplientStatus({this.updateJobApplicantsByPk});

  JobapplientStatus.fromJson(Map<String, dynamic> json) {
    updateJobApplicantsByPk = json['update_job_applicants_by_pk'] != null
        ? new UpdateJobApplicantsByPk.fromJson(
            json['update_job_applicants_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.updateJobApplicantsByPk != null) {
      data['update_job_applicants_by_pk'] =
          this.updateJobApplicantsByPk!.toJson();
    }
    return data;
  }
}

class UpdateJobApplicantsByPk {
  String? id;
  String? status;
  String? sTypename;

  UpdateJobApplicantsByPk({this.id, this.status, this.sTypename});

  UpdateJobApplicantsByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['__typename'] = this.sTypename;
    return data;
  }
}
