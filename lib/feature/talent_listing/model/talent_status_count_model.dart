class GetTalentStatusCountResp {
  TalentStatusCountData? data;

  GetTalentStatusCountResp({this.data});

  GetTalentStatusCountResp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? TalentStatusCountData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TalentStatusCountData {
  TalentStatusCountItem? all;
  TalentStatusCountItem? approved;
  TalentStatusCountItem? pending;
  TalentStatusCountItem? rejected;

  TalentStatusCountData({this.all, this.approved, this.pending, this.rejected});

  TalentStatusCountData.fromJson(Map<String, dynamic> json) {
    all = json['all'] != null ? TalentStatusCountItem.fromJson(json['all']) : null;
    approved = json['approved'] != null ? TalentStatusCountItem.fromJson(json['approved']) : null;
    pending = json['pending'] != null ? TalentStatusCountItem.fromJson(json['pending']) : null;
    rejected = json['rejected'] != null ? TalentStatusCountItem.fromJson(json['rejected']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (all != null) data['all'] = all!.toJson();
    if (approved != null) data['approved'] = approved!.toJson();
    if (pending != null) data['pending'] = pending!.toJson();
    if (rejected != null) data['rejected'] = rejected!.toJson();
    return data;
  }
}

class TalentStatusCountItem {
  Aggregate? aggregate;

  TalentStatusCountItem({this.aggregate});

  TalentStatusCountItem.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? Aggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (aggregate != null) {
      data['aggregate'] = aggregate!.toJson();
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
    final Map<String, dynamic> data = {};
    data['count'] = count;
    return data;
  }
}
