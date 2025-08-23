class TalentListingCountRes {
  TalentListingCountData? data;

  TalentListingCountRes({this.data});

  TalentListingCountRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? TalentListingCountData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (data != null) {
      result['data'] = data!.toJson();
    }
    return result;
  }
}

class TalentListingCountData {
  All? all;
  Approved? approved;
  Pending? pending;
  Rejected? rejected;
  Enquiry? enquiry;
  Cancelled? cancelled;

  TalentListingCountData({
    this.all,
    this.approved,
    this.pending,
    this.rejected,
    this.enquiry,
    this.cancelled,
  });

  TalentListingCountData.fromJson(Map<String, dynamic> json) {
    all = json['all'] != null ? All.fromJson(json['all']) : null;
    approved = json['approved'] != null ? Approved.fromJson(json['approved']) : null;
    pending = json['pending'] != null ? Pending.fromJson(json['pending']) : null;
    rejected = json['rejected'] != null ? Rejected.fromJson(json['rejected']) : null;
    enquiry = json['enquiry'] != null ? Enquiry.fromJson(json['enquiry']) : null;
    cancelled = json['cancelled'] != null ? Cancelled.fromJson(json['cancelled']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (all != null) result['all'] = all!.toJson();
    if (approved != null) result['approved'] = approved!.toJson();
    if (pending != null) result['pending'] = pending!.toJson();
    if (rejected != null) result['rejected'] = rejected!.toJson();
    if (enquiry != null) result['enquiry'] = enquiry!.toJson();
    if (cancelled != null) result['cancelled'] = cancelled!.toJson();
    return result;
  }
}

class All {
  Aggregate? aggregate;

  All({this.aggregate});

  All.fromJson(Map<String, dynamic> json) {
    aggregate =
        json['aggregate'] != null ? Aggregate.fromJson(json['aggregate']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (aggregate != null) result['aggregate'] = aggregate!.toJson();
    return result;
  }
}

class Approved {
  ApprovedAggregate? aggregate;

  Approved({this.aggregate});

  Approved.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? ApprovedAggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (aggregate != null) result['aggregate'] = aggregate!.toJson();
    return result;
  }
}

class ApprovedAggregate {
  int? count;

  ApprovedAggregate({this.count});

  ApprovedAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() => {"count": count};
}

class Pending {
  PendingAggregate? aggregate;

  Pending({this.aggregate});

  Pending.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? PendingAggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (aggregate != null) result['aggregate'] = aggregate!.toJson();
    return result;
  }
}

class PendingAggregate {
  int? count;

  PendingAggregate({this.count});

  PendingAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() => {"count": count};
}

class Rejected {
  RejectedAggregate? aggregate;

  Rejected({this.aggregate});

  Rejected.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? RejectedAggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (aggregate != null) result['aggregate'] = aggregate!.toJson();
    return result;
  }
}

class RejectedAggregate {
  int? count;

  RejectedAggregate({this.count});

  RejectedAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() => {"count": count};
}

class Enquiry {
  EnquiryAggregate? aggregate;

  Enquiry({this.aggregate});

  Enquiry.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? EnquiryAggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (aggregate != null) result['aggregate'] = aggregate!.toJson();
    return result;
  }
}

class EnquiryAggregate {
  int? count;

  EnquiryAggregate({this.count});

  EnquiryAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() => {"count": count};
}

class Cancelled {
  CancelledAggregate? aggregate;

  Cancelled({this.aggregate});

  Cancelled.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? CancelledAggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (aggregate != null) result['aggregate'] = aggregate!.toJson();
    return result;
  }
}

class CancelledAggregate {
  int? count;

  CancelledAggregate({this.count});

  CancelledAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() => {"count": count};
}

class Aggregate {
  int? count;

  Aggregate({this.count});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() => {"count": count};
}
