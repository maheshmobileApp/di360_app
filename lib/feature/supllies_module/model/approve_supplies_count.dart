class ApproveSuppliesCount {
  ApproveSuppliesData? data;

  ApproveSuppliesCount({this.data});

  ApproveSuppliesCount.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new ApproveSuppliesData.fromJson(json['data'])
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

class ApproveSuppliesData {
  Approved? approved;

  ApproveSuppliesData({this.approved});

  ApproveSuppliesData.fromJson(Map<String, dynamic> json) {
    approved = json['approved'] != null
        ? new Approved.fromJson(json['approved'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.approved != null) {
      data['approved'] = this.approved!.toJson();
    }
    return data;
  }
}

class Approved {
  Aggregate? aggregate;
  String? sTypename;

  Approved({this.aggregate, this.sTypename});

  Approved.fromJson(Map<String, dynamic> json) {
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
