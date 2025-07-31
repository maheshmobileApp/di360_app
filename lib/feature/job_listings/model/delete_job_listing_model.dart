class DeleteJobListingResp {
  Data? data;

  DeleteJobListingResp({this.data});

  DeleteJobListingResp.fromJson(Map<String, dynamic> json) {
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
  DeleteJobsByPk? deleteJobsByPk;

  Data({this.deleteJobsByPk});

  Data.fromJson(Map<String, dynamic> json) {
    deleteJobsByPk = json['delete_jobs_by_pk'] != null
        ? new DeleteJobsByPk.fromJson(json['delete_jobs_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deleteJobsByPk != null) {
      data['delete_jobs_by_pk'] = this.deleteJobsByPk!.toJson();
    }
    return data;
  }
}

class DeleteJobsByPk {
  String? id;
  String? sTypename;

  DeleteJobsByPk({this.id, this.sTypename});

  DeleteJobsByPk.fromJson(Map<String, dynamic> json) {
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
