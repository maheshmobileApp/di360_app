class DraftSuppliesCount {
  DraftSuppliesData? data;

  DraftSuppliesCount({this.data});

  DraftSuppliesCount.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DraftSuppliesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DraftSuppliesData {
  Draft? draft;

  DraftSuppliesData({this.draft});

  DraftSuppliesData.fromJson(Map<String, dynamic> json) {
    draft = json['draft'] != null ? new Draft.fromJson(json['draft']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.draft != null) {
      data['draft'] = this.draft!.toJson();
    }
    return data;
  }
}

class Draft {
  Aggregate? aggregate;
  String? sTypename;

  Draft({this.aggregate, this.sTypename});

  Draft.fromJson(Map<String, dynamic> json) {
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
