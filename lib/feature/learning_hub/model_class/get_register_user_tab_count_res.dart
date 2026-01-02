class GetRegisterUserTabCountRes {
  RegisterUserTabCountData? data;

  GetRegisterUserTabCountRes({this.data});

  GetRegisterUserTabCountRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new RegisterUserTabCountData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RegisterUserTabCountData {
  All? all;
  All? pending;
  All? approved;
  All? cancelled;
  All? completed;

  RegisterUserTabCountData({this.all, this.pending, this.approved, this.cancelled, this.completed});

  RegisterUserTabCountData.fromJson(Map<String, dynamic> json) {
    all = json['all'] != null ? new All.fromJson(json['all']) : null;
    pending =
        json['pending'] != null ? new All.fromJson(json['pending']) : null;
    approved =
        json['approved'] != null ? new All.fromJson(json['approved']) : null;
    cancelled =
        json['cancelled'] != null ? new All.fromJson(json['cancelled']) : null;
    completed =
        json['completed'] != null ? new All.fromJson(json['completed']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.all != null) {
      data['all'] = this.all!.toJson();
    }
    if (this.pending != null) {
      data['pending'] = this.pending!.toJson();
    }
    if (this.approved != null) {
      data['approved'] = this.approved!.toJson();
    }
    if (this.cancelled != null) {
      data['cancelled'] = this.cancelled!.toJson();
    }
    if (this.completed != null) {
      data['completed'] = this.completed!.toJson();
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
