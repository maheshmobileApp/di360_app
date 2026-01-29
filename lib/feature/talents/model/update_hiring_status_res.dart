class UpdateHiringStatusRes {
  UpdateHiringStatusData? data;

  UpdateHiringStatusRes({this.data});

  UpdateHiringStatusRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UpdateHiringStatusData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UpdateHiringStatusData {
  UpdateJobhiringsByPk? updateJobhiringsByPk;

  UpdateHiringStatusData({this.updateJobhiringsByPk});

  UpdateHiringStatusData.fromJson(Map<String, dynamic> json) {
    updateJobhiringsByPk = json['update_jobhirings_by_pk'] != null
        ? new UpdateJobhiringsByPk.fromJson(json['update_jobhirings_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.updateJobhiringsByPk != null) {
      data['update_jobhirings_by_pk'] = this.updateJobhiringsByPk!.toJson();
    }
    return data;
  }
}

class UpdateJobhiringsByPk {
  String? id;
  String? hiringStatus;
  String? sTypename;

  UpdateJobhiringsByPk({this.id, this.hiringStatus, this.sTypename});

  UpdateJobhiringsByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hiringStatus = json['hiring_status'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hiring_status'] = this.hiringStatus;
    data['__typename'] = this.sTypename;
    return data;
  }
}
