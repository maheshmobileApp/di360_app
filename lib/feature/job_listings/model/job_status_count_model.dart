class GetJobStatusCountResp {
  JobStatusCountData? data;

  GetJobStatusCountResp({this.data});

  GetJobStatusCountResp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new JobStatusCountData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class JobStatusCountData {
  All? all;
  All? active;
  All? approved;
  All? pending;
  All? rejected;
  All? inactive;
  All? draft;
  All? scheduled;
  All? expired;

  JobStatusCountData(
      {this.all,
      this.active,
      this.approved,
      this.pending,
      this.rejected,
      this.inactive,
      this.draft,
      this.scheduled,
      this.expired});

  JobStatusCountData.fromJson(Map<String, dynamic> json) {
    all = json['all'] != null ? new All.fromJson(json['all']) : null;
    active = json['active'] != null ? new All.fromJson(json['active']) : null;
    approved =
        json['approved'] != null ? new All.fromJson(json['approved']) : null;
    pending =
        json['pending'] != null ? new All.fromJson(json['pending']) : null;
    rejected =
        json['rejected'] != null ? new All.fromJson(json['rejected']) : null;
    inactive =
        json['inactive'] != null ? new All.fromJson(json['inactive']) : null;
    draft = json['draft'] != null ? new All.fromJson(json['draft']) : null;
    scheduled =
        json['scheduled'] != null ? new All.fromJson(json['scheduled']) : null;
    expired =
        json['expired'] != null ? new All.fromJson(json['expired']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.all != null) {
      data['all'] = this.all!.toJson();
    }
    if (this.active != null) {
      data['active'] = this.active!.toJson();
    }
    if (this.approved != null) {
      data['approved'] = this.approved!.toJson();
    }
    if (this.pending != null) {
      data['pending'] = this.pending!.toJson();
    }
    if (this.rejected != null) {
      data['rejected'] = this.rejected!.toJson();
    }
    if (this.inactive != null) {
      data['inactive'] = this.inactive!.toJson();
    }
    if (this.draft != null) {
      data['draft'] = this.draft!.toJson();
    }
    if (this.scheduled != null) {
      data['scheduled'] = this.scheduled!.toJson();
    }
    if (this.expired != null) {
      data['expired'] = this.expired!.toJson();
    }
    return data;
  }
}

class All {
  Aggregate? aggregate;

  All({this.aggregate});

  All.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class Aggregate {
  int? count;

  Aggregate({this.count});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}
