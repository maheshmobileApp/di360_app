class GetTalentListingStatusCountRes {
  TalentListingStatusCount? data;

  GetTalentListingStatusCountRes({this.data});

  GetTalentListingStatusCountRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TalentListingStatusCount.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TalentListingStatusCount {
  All? all;
  All? pending;
  All? approve;
  All? rejected;
  All? cancelled;

  TalentListingStatusCount({this.all, this.pending, this.approve, this.rejected, this.cancelled});

  TalentListingStatusCount.fromJson(Map<String, dynamic> json) {
    all = json['all'] != null ? new All.fromJson(json['all']) : null;
    pending =
        json['pending'] != null ? new All.fromJson(json['pending']) : null;
    approve =
        json['approve'] != null ? new All.fromJson(json['approve']) : null;
    rejected =
        json['rejected'] != null ? new All.fromJson(json['rejected']) : null;
    cancelled =
        json['cancelled'] != null ? new All.fromJson(json['cancelled']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.all != null) {
      data['all'] = this.all!.toJson();
    }
    if (this.pending != null) {
      data['pending'] = this.pending!.toJson();
    }
    if (this.approve != null) {
      data['approve'] = this.approve!.toJson();
    }
    if (this.rejected != null) {
      data['rejected'] = this.rejected!.toJson();
    }
    if (this.cancelled != null) {
      data['cancelled'] = this.cancelled!.toJson();
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
