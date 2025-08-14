class TalentListingCountRes {
  TalentData? data;

  TalentListingCountRes({this.data});

  TalentListingCountRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TalentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
class TalentData {
  All? all;
  Approved? approved;
  Pending? pending;
  Rejected? rejected;
  Enquiry? enquiry;
  Cancelled? cancelled;
  TalentData(
      {this.all,
      this.approved,
      this.pending,
      this.rejected,
      this.enquiry,
      this.cancelled});

  TalentData.fromJson(Map<String, dynamic> json) {
    all = json['all'] != null ? new All.fromJson(json['all']) : null;
    approved =
        json['approved'] != null ? new Approved.fromJson(json['approved']) : null;
    pending =
        json['pending'] != null ? new Pending.fromJson(json['pending']) : null;
    rejected =
        json['rejected'] != null ? new Rejected.fromJson(json['rejected']) : null;
    enquiry =
        json['enquiry'] != null ? new Enquiry.fromJson(json['enquiry']) : null;
    cancelled =
        json['cancelled'] != null ? new Cancelled.fromJson(json['cancelled']) : null;
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
    if (this.enquiry != null) {
      data['enquiry'] = this.enquiry!.toJson();
    }
    if (this.cancelled != null) {
      data['cancelled'] = this.cancelled!.toJson();
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

class Enquiry {
  EnquiryAggregate? aggregate;

  Enquiry({this.aggregate});

  Enquiry.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new EnquiryAggregate.fromJson(json['aggregate'])
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

class EnquiryAggregate {
  int? count;

  EnquiryAggregate({this.count});
  
  EnquiryAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

class Cancelled {
  CancelledAggregate? aggregate;

  Cancelled({this.aggregate});

  Cancelled.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new CancelledAggregate.fromJson(json['aggregate'])
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

class CancelledAggregate {
  int? count;

  CancelledAggregate({this.count});

  CancelledAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

