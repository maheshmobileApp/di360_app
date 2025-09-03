class GetJobApllicantsCountResp {
  GetJobApllicantsCountData? data;

  GetJobApllicantsCountResp({this.data});

  GetJobApllicantsCountResp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? GetJobApllicantsCountData.fromJson(json['data'])
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

class GetJobApllicantsCountData {
  All? all;
  Applied? applied;
  Interviews? interviews;
  Accepted? accepted;
  Rejected? rejected;
  Shortlisted? shortlisted;
  All? declined;


  GetJobApllicantsCountData(
      {this.all,
      this.applied,
      this.interviews,
      this.accepted,
      this.rejected,
      this.shortlisted});

  GetJobApllicantsCountData.fromJson(Map<String, dynamic> json) {
    all = json['all'] != null ? All.fromJson(json['all']) : null;
    applied = json['applied'] != null ? Applied.fromJson(json['applied']) : null;
    interviews = json['interviews'] != null
        ? Interviews.fromJson(json['interviews'])
        : null;
    accepted =
        json['accepted'] != null ? Accepted.fromJson(json['accepted']) : null;
    rejected =
        json['rejected'] != null ? Rejected.fromJson(json['rejected']) : null;
    shortlisted = json['shortlisted'] != null
        ? Shortlisted.fromJson(json['shortlisted'])
        : null;
    declined = json['declined'] != null ? All.fromJson(json['declined']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (all != null) result['all'] = all!.toJson();
    if (applied != null) result['applied'] = applied!.toJson();
    if (interviews != null) result['interviews'] = interviews!.toJson();
    if (accepted != null) result['accepted'] = accepted!.toJson();
    if (rejected != null) result['rejected'] = rejected!.toJson();
    if (shortlisted != null) result['shortlisted'] = shortlisted!.toJson();
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
    if (aggregate != null) {
      result['aggregate'] = aggregate!.toJson();
    }
    return result;
  }
}
class Applied {
  AppliedAggregate? aggregate;

  Applied({this.aggregate});

  Applied.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? AppliedAggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (aggregate != null) {
      result['aggregate'] = aggregate!.toJson();
    }
    return result;
  }
}

class AppliedAggregate {
  int? count;

  AppliedAggregate({this.count});

  AppliedAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    return {"count": count};
  }
}

class Interviews {
  InterviewsAggregate? aggregate;

  Interviews({this.aggregate});

  Interviews.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? InterviewsAggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (aggregate != null) {
      result['aggregate'] = aggregate!.toJson();
    }
    return result;
  }
}

class InterviewsAggregate {
  int? count;

  InterviewsAggregate({this.count});

  InterviewsAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    return {"count": count};
  }
}

class Accepted {
  AcceptedAggregate? aggregate;

  Accepted({this.aggregate});

  Accepted.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? AcceptedAggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (aggregate != null) {
      result['aggregate'] = aggregate!.toJson();
    }
    return result;
  }
}

class AcceptedAggregate {
  int? count;

  AcceptedAggregate({this.count});

  AcceptedAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    return {"count": count};
  }
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
    if (aggregate != null) {
      result['aggregate'] = aggregate!.toJson();
    }
    return result;
  }
}

class RejectedAggregate {
  int? count;

  RejectedAggregate({this.count});

  RejectedAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    return {"count": count};
  }
}
class Shortlisted {
  ShortlistedAggregate? aggregate;

  Shortlisted({this.aggregate});

  Shortlisted.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? ShortlistedAggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (aggregate != null) {
      result['aggregate'] = aggregate!.toJson();
    }
    return result;
  }
}

class ShortlistedAggregate {
  int? count;

  ShortlistedAggregate({this.count});

  ShortlistedAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    return {"count": count};
  }
}

class Aggregate {
  int? count;

  Aggregate({this.count});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    return {"count": count};
  }
}
