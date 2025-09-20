class GetCourseStatusCountResp {
  CourseStatusCountData? data;

  GetCourseStatusCountResp({this.data});

  GetCourseStatusCountResp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CourseStatusCountData.fromJson(json['data']) : null;
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
  Approve? approve;
  Rejected? rejected;
  Draft? draft;
  Pending? pending;

  CourseStatusCountData({this.all, this.approve, this.rejected, this.draft, this.pending});

  CourseStatusCountData.fromJson(Map<String, dynamic> json) {
    all = json['all'] != null ? new All.fromJson(json['all']) : null;
    approve =
        json['approve'] != null ? new Approve.fromJson(json['approve']) : null;
    rejected =
        json['rejected'] != null ? new Rejected.fromJson(json['rejected']) : null;
    draft = json['draft'] != null ? new Draft.fromJson(json['draft']) : null;
    pending =
        json['pending'] != null ? new Pending.fromJson(json['pending']) : null;
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

class Approve {
  ApproveAggregate? aggregate;

  Approve({this.aggregate});

  Approve.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new ApproveAggregate.fromJson(json['aggregate'])
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
class Rejected {
  RejectedAggregate? aggregate;

  Rejected({this.aggregate});

  Rejected.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new RejectedAggregate.fromJson(json['aggregate'])
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
class Draft {
  DraftAggregate? aggregate;

  Draft({this.aggregate});

  Draft.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new DraftAggregate.fromJson(json['aggregate'])
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

class Pending {
  PendingAggregate? aggregate;

  Pending({this.aggregate});

  Pending.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new PendingAggregate.fromJson(json['aggregate'])
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
class ApproveAggregate {
  int? count;

  ApproveAggregate({this.count});

  ApproveAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}
class RejectedAggregate {
  int? count;

  RejectedAggregate({this.count});

  RejectedAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}
class DraftAggregate {
  int? count;

  DraftAggregate({this.count});

  DraftAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}
class PendingAggregate {
  int? count;

  PendingAggregate({this.count});

  PendingAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}
