class TalentListingCountRes {
 TalentListingCountData? data;

  TalentListingCountRes({this.data});

  TalentListingCountRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TalentListingCountData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TalentListingCountData {
  All? all;
  All? approved;
  All? pending;
  All? rejected;
  All? enquiry;
  All? cancelled;

TalentListingCountData(
      {this.all,
      this.approved,
      this.pending,
      this.rejected,
      this.enquiry,
      this.cancelled});

TalentListingCountData.fromJson(Map<String, dynamic> json) {
    all = json['all'] != null ? new All.fromJson(json['all']) : null;
    approved =
        json['approved'] != null ? new All.fromJson(json['approved']) : null;
    pending =
        json['pending'] != null ? new All.fromJson(json['pending']) : null;
    rejected =
        json['rejected'] != null ? new All.fromJson(json['rejected']) : null;
    enquiry =
        json['enquiry'] != null ? new All.fromJson(json['enquiry']) : null;
    cancelled =
        json['cancelled'] != null ? new All.fromJson(json['cancelled']) : null;
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
