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

  CatalogueCountData(
      {this.all,
      this.approved,
      this.pending,
      this.rejected,
      this.expired,
      this.draft,
      this.scheduled});

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

class Approved {
  ApprovedAggregate? aggregate;

  Approved({this.aggregate});

  Approved.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new ApprovedAggregate.fromJson(json['aggregate'])
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

class ApprovedAggregate {
  int? count;

  ApprovedAggregate({this.count});

  ApprovedAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
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

class Expired {
  ExpiredAggregate? aggregate;

  Expired({this.aggregate});

  Expired.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new ExpiredAggregate.fromJson(json['aggregate'])
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

class ExpiredAggregate {
  int? count;

  ExpiredAggregate({this.count});

  ExpiredAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
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

class Scheduled {
  ScheduledAggregate? aggregate;

  Scheduled({this.aggregate});

  Scheduled.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new ScheduledAggregate.fromJson(json['aggregate'])
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

class ScheduledAggregate {
  int? count;

  ScheduledAggregate({this.count});

  ScheduledAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}
