class GetCourseStatusCountResp {
  CourseStatusCountData? data;

  GetCourseStatusCountResp({this.data});

  GetCourseStatusCountResp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new CourseStatusCountData.fromJson(json['data'])
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

class CourseStatusCountData {
  All? all;
  All? approve;
  All? rejected;
  All? draft;
  All? pending;
  All? expired;
  All? active;
  All? inactive;

  CourseStatusCountData(
      {this.all,
      this.approve,
      this.rejected,
      this.draft,
      this.pending,
      this.expired,
      this.active,
      this.inactive});

  CourseStatusCountData.fromJson(Map<String, dynamic> json) {
    all = json['all'] != null ? new All.fromJson(json['all']) : null;
    approve =
        json['approve'] != null ? new All.fromJson(json['approve']) : null;
    rejected =
        json['rejected'] != null ? new All.fromJson(json['rejected']) : null;
    draft = json['draft'] != null ? new All.fromJson(json['draft']) : null;
    pending =
        json['pending'] != null ? new All.fromJson(json['pending']) : null;
    expired =
        json['expired'] != null ? new All.fromJson(json['expired']) : null;
    active = json['active'] != null ? new All.fromJson(json['active']) : null;
    inactive =
        json['inactive'] != null ? new All.fromJson(json['inactive']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.all != null) {
      data['all'] = this.all!.toJson();
    }
    if (this.approve != null) {
      data['approve'] = this.approve!.toJson();
    }
    if (this.rejected != null) {
      data['rejected'] = this.rejected!.toJson();
    }
    if (this.draft != null) {
      data['draft'] = this.draft!.toJson();
    }
    if (this.pending != null) {
      data['pending'] = this.pending!.toJson();
    }
    if (this.expired != null) {
      data['expired'] = this.expired!.toJson();
    }
    if (this.active != null) {
      data['active'] = this.active!.toJson();
    }
    if (this.inactive != null) {
      data['inactive'] = this.inactive!.toJson();
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
