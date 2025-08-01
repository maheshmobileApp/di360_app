class UpdateJobListingStatusResp {
  Data? data;

  UpdateJobListingStatusResp({this.data});

  UpdateJobListingStatusResp.fromJson(Map<String, dynamic> json) {
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
  UpdateJobsByPk? updateJobsByPk;

  Data({this.updateJobsByPk});

  Data.fromJson(Map<String, dynamic> json) {
    updateJobsByPk = json['update_jobs_by_pk'] != null
        ? new UpdateJobsByPk.fromJson(json['update_jobs_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.updateJobsByPk != null) {
      data['update_jobs_by_pk'] = this.updateJobsByPk!.toJson();
    }
    return data;
  }
}

class UpdateJobsByPk {
  String? id;
  String? activeStatus;
  String? sTypename;

  UpdateJobsByPk({this.id, this.activeStatus, this.sTypename});

  UpdateJobsByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activeStatus = json['active_status'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active_status'] = this.activeStatus;
    data['__typename'] = this.sTypename;
    return data;
  }
}
