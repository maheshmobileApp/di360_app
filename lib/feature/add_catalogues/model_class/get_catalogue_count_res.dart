class GetCatalogueCountRes {
  CatalogueCountData? data;

  GetCatalogueCountRes({this.data});

  GetCatalogueCountRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new CatalogueCountData.fromJson(json['data'])
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

class CatalogueCountData {
  All? all;
  Approved? approved;
  Pending? pending;
  Rejected? rejected;
  Expired? expired;
  Draft? draft;
  Scheduled? scheduled;
  ApprovalPending? approvalPending;
  Inactive? inactive;

  CatalogueCountData(
      {this.all,
      this.approved,
      this.pending,
      this.rejected,
      this.expired,
      this.draft,
      this.scheduled,
      this.approvalPending,
      this.inactive});

  CatalogueCountData.fromJson(Map<String, dynamic> json) {
    all = json['all'] != null ? new All.fromJson(json['all']) : null;
    approved = json['approved'] != null
        ? new Approved.fromJson(json['approved'])
        : null;
    pending =
        json['pending'] != null ? new Pending.fromJson(json['pending']) : null;
    rejected = json['rejected'] != null
        ? new Rejected.fromJson(json['rejected'])
        : null;
    expired =
        json['expired'] != null ? new Expired.fromJson(json['expired']) : null;
    draft = json['draft'] != null ? new Draft.fromJson(json['draft']) : null;
    scheduled = json['scheduled'] != null
        ? new Scheduled.fromJson(json['scheduled'])
        : null;
    approvalPending = json['approval_pending'] != null ? new ApprovalPending.fromJson(json['approval_pending']) : null;
    inactive = json['inactive'] != null ? new Inactive.fromJson(json['inactive']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.all != null) {
      data['all'] = this.all!.toJson();
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
    if (this.expired != null) {
      data['expired'] = this.expired!.toJson();
    }
    if (this.draft != null) {
      data['draft'] = this.draft!.toJson();
    }
    if (this.scheduled != null) {
      data['scheduled'] = this.scheduled!.toJson();
    }
    return data;
  }
}

class All {
  Aggregate? aggregate;
  String? sTypename;

  All({this.aggregate, this.sTypename});

  All.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Aggregate {
  int? count;
  String? sTypename;

  Aggregate({this.count, this.sTypename});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Approved {
  ApprovedAggregate? aggregate;
  String? sTypename;

  Approved({this.aggregate,this.sTypename});

  Approved.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new ApprovedAggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class ApprovedAggregate {
  int? count;
  String? sTypename;

  ApprovedAggregate({this.count,this.sTypename});

  ApprovedAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

class Pending {
  PendingAggregate? aggregate;
  String? sTypename;

  Pending({this.aggregate,this.sTypename});

  Pending.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new PendingAggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class PendingAggregate {
  int? count;
  String? sTypename;

  PendingAggregate({this.count,this.sTypename});

  PendingAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

class Rejected {
  RejectedAggregate? aggregate;
  String? sTypename;

  Rejected({this.aggregate,this.sTypename});

  Rejected.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new RejectedAggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class RejectedAggregate {
  int? count;
  String? sTypename;

  RejectedAggregate({this.count,this.sTypename});

  RejectedAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

class Expired {
  ExpiredAggregate? aggregate;
  String? sTypename;

  Expired({this.aggregate,this.sTypename});

  Expired.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new ExpiredAggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class ExpiredAggregate {
  int? count;
  String? sTypename;

  ExpiredAggregate({this.count,this.sTypename});

  ExpiredAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

class Draft {
  DraftAggregate? aggregate;
  String? sTypename;

  Draft({this.aggregate,this.sTypename});

  Draft.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new DraftAggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class DraftAggregate {
  int? count;
  String? sTypename;

  DraftAggregate({this.count,this.sTypename});

  DraftAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

class Scheduled {
  ScheduledAggregate? aggregate;
  String? sTypename;

  Scheduled({this.aggregate,this.sTypename});

  Scheduled.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new ScheduledAggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class ScheduledAggregate {
  int? count;
  String? sTypename;

  ScheduledAggregate({this.count,this.sTypename});

  ScheduledAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

class Inactive {
  InactiveAggregate? aggregate;
  String? sTypename;

  Inactive({this.aggregate,this.sTypename});

  Inactive.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new InactiveAggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class InactiveAggregate {
  int? count;
  String? sTypename;

  InactiveAggregate({this.count,this.sTypename});

  InactiveAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

class ApprovalPending {
  ApprovalPendingAggregate? aggregate;
  String? sTypename;

  ApprovalPending({this.aggregate,this.sTypename});

  ApprovalPending.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new ApprovalPendingAggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class ApprovalPendingAggregate {
  int? count;
  String? sTypename;

  ApprovalPendingAggregate({this.count,this.sTypename});

  ApprovalPendingAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}
