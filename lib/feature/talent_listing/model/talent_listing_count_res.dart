class TalentListingCountRes {
  All? all;
  All? pending;
  All? approve;
  All? rejected;

  TalentListingCountRes({this.all, this.pending, this.approve, this.rejected});

  factory TalentListingCountRes.fromJson(Map<String, dynamic> json) {
    return TalentListingCountRes(
      all: json['all'] != null ? All.fromJson(json['all']) : null,
      pending: json['pending'] != null ? All.fromJson(json['pending']) : null,
      approve: json['approve'] != null ? All.fromJson(json['approve']) : null,
      rejected: json['rejected'] != null ? All.fromJson(json['rejected']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'all': all?.toJson(),
      'pending': pending?.toJson(),
      'approve': approve?.toJson(),
      'rejected': rejected?.toJson(),
    };
  }
}

class All {
  Aggregate? aggregate;
  String? sTypename;

  All({this.aggregate, this.sTypename});

  factory All.fromJson(Map<String, dynamic> json) {
    return All(
      aggregate:
          json['aggregate'] != null ? Aggregate.fromJson(json['aggregate']) : null,
      sTypename: json['__typename'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aggregate': aggregate?.toJson(),
      '__typename': sTypename,
    };
  }
}

class Aggregate {
  int? count;
  String? sTypename;

  Aggregate({this.count, this.sTypename});

  factory Aggregate.fromJson(Map<String, dynamic> json) {
    return Aggregate(
      count: json['count'],
      sTypename: json['__typename'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      '__typename': sTypename,
    };
  }
}
