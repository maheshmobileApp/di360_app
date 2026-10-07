class RequestCountRes {
  RequestCountData? data;

  RequestCountRes({this.data});

  RequestCountRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new RequestCountData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RequestCountData {
  Pending? pending;
  Pending? approve;
  Pending? reject;

  RequestCountData({this.pending, this.approve, this.reject});

  RequestCountData.fromJson(Map<String, dynamic> json) {
    pending =
        json['pending'] != null ? new Pending.fromJson(json['pending']) : null;
    approve =
        json['approve'] != null ? new Pending.fromJson(json['approve']) : null;
    reject =
        json['reject'] != null ? new Pending.fromJson(json['reject']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pending != null) {
      data['pending'] = this.pending!.toJson();
    }
    if (this.approve != null) {
      data['approve'] = this.approve!.toJson();
    }
    if (this.reject != null) {
      data['reject'] = this.reject!.toJson();
    }
    return data;
  }
}

class Pending {
  Aggregate? aggregate;
  String? sTypename;

  Pending({this.aggregate, this.sTypename});

  Pending.fromJson(Map<String, dynamic> json) {
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
