
class getBannersCount {
  BannersCountData? data;

  getBannersCount({this.data});

  getBannersCount.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new BannersCountData.fromJson(json['data'])
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

class BannersCountData {
  ALL? aLL;
  Approved? approved;
  Rejected? rejected;
  Pending? pending;
  Expired? expired;
  Scheduled? scheduled;
  Draft? draft;

  BannersCountData(
      {this.aLL,
      this.approved,
      this.rejected,
      this.pending,
      this.expired,
      this.scheduled,
      this.draft});

  BannersCountData.fromJson(Map<String, dynamic> json) {
    aLL = json['ALL'] != null
        ? ALL.fromJson(json['ALL'] as Map<String, dynamic>)
        : null;
    approved = json['approved'] != null
        ? Approved.fromJson(json['approved'] as Map<String, dynamic>)
        : null;
    rejected = json['rejected'] != null
        ? Rejected.fromJson(json['rejected'] as Map<String, dynamic>)
        : null;
    pending = json['pending'] != null
        ? Pending.fromJson(json['pending'] as Map<String, dynamic>)
        : null;
    expired = json['expired'] != null
        ? Expired.fromJson(json['expired'] as Map<String, dynamic>)
        : null;
    scheduled = json['scheduled'] != null
        ? Scheduled.fromJson(json['scheduled'] as Map<String, dynamic>)
        : null;
    draft = json['draft'] != null
        ? Draft.fromJson(json['draft'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aLL != null) {
      data['ALL'] = this.aLL!.toJson();
    }
    if (this.approved != null) {
      data['approved'] = this.approved!.toJson();
    }
    if (this.rejected != null) {
      data['rejected'] = this.rejected!.toJson();
    }
    if (this.pending != null) {
      data['pending'] = this.pending!.toJson();
    }
    if (this.expired != null) {
      data['expired'] = this.expired!.toJson();
    }
    if (this.scheduled != null) {
      data['scheduled'] = this.scheduled!.toJson();
    }
    if (this.draft != null) {
      data['draft'] = this.draft!.toJson();
    }
    return data;
  }
}

class ALL {
  Aggregate? aggregate;

  ALL({this.aggregate});

  ALL.fromJson(Map<String, dynamic> json) {
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

//rejected
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

//pendind
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

//expired
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

//schudule
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

//Draft
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
