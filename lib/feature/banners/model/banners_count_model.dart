class GetBannersCount {
  final BannerCountData? data;

  GetBannersCount({this.data});

  factory GetBannersCount.fromJson(Map<String, dynamic> json) {
    return GetBannersCount(
      data: json['data'] != null
          ? BannerCountData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class BannerCountData {
  final All? all;
  final All? draft;
  final All? pending;
  final All? active;
  final All? inactive;
  final All? scheduled;
  final All? rejected;
  final All? expired;

  BannerCountData({
    this.all,
    this.draft,
    this.pending,
    this.active,
    this.inactive,
    this.scheduled,
    this.rejected,
    this.expired,
  });

  factory BannerCountData.fromJson(Map<String, dynamic> json) {
    return BannerCountData(
      all: json['all'] != null
          ? All.fromJson(json['all'] as Map<String, dynamic>)
          : null,
      draft: json['draft'] != null
          ? All.fromJson(json['draft'] as Map<String, dynamic>)
          : null,
      pending: json['pending'] != null
          ? All.fromJson(json['pending'] as Map<String, dynamic>)
          : null,
      active: json['active'] != null
          ? All.fromJson(json['active'] as Map<String, dynamic>)
          : null,
      inactive: json['inactive'] != null
          ? All.fromJson(json['inactive'] as Map<String, dynamic>)
          : null,
      scheduled: json['scheduled'] != null
          ? All.fromJson(json['scheduled'] as Map<String, dynamic>)
          : null,
      rejected: json['rejected'] != null
          ? All.fromJson(json['rejected'] as Map<String, dynamic>)
          : null,
      expired: json['expired'] != null
          ? All.fromJson(json['expired'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'all': all?.toJson(),
      'draft': draft?.toJson(),
      'pending': pending?.toJson(),
      'active': active?.toJson(),
      'inactive': inactive?.toJson(),
      'scheduled': scheduled?.toJson(),
      'rejected': rejected?.toJson(),
      'expired': expired?.toJson(),
    };
  }
}

class All {
  final Aggregate? aggregate;
  final String typename;

  All({
    this.aggregate,
    required this.typename,
  });

  factory All.fromJson(Map<String, dynamic> json) {
    return All(
      aggregate: json['aggregate'] != null
          ? Aggregate.fromJson(json['aggregate'] as Map<String, dynamic>)
          : null,
      typename: json['__typename']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aggregate': aggregate?.toJson(),
      '__typename': typename,
    };
  }
}

class Aggregate {
  final int count;
  final String typename;

  Aggregate({
    required this.count,
    required this.typename,
  });

  factory Aggregate.fromJson(Map<String, dynamic> json) {
    return Aggregate(
      count: json['count'] ?? 0,
      typename: json['__typename']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      '__typename': typename,
    };
  }
}