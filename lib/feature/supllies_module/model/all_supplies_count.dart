class AllSuppliesCount {
  AllSuppliesData? data;

  AllSuppliesCount({this.data});

  AllSuppliesCount.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AllSuppliesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AllSuppliesData {
  SuppliesAggregate? suppliesAggregate;

  AllSuppliesData({this.suppliesAggregate});

  AllSuppliesData.fromJson(Map<String, dynamic> json) {
    suppliesAggregate = json['supplies_aggregate'] != null
        ? new SuppliesAggregate.fromJson(json['supplies_aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.suppliesAggregate != null) {
      data['supplies_aggregate'] = this.suppliesAggregate!.toJson();
    }
    return data;
  }
}

class SuppliesAggregate {
  Aggregate? aggregate;
  String? sTypename;

  SuppliesAggregate({this.aggregate, this.sTypename});

  SuppliesAggregate.fromJson(Map<String, dynamic> json) {
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
