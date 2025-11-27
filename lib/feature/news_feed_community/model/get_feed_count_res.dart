class FeedCountRes {
  FeedCountData? data;

  FeedCountRes({this.data});

  FeedCountRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new FeedCountData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FeedCountData {
  NewsfeedsAggregate? newsfeedsAggregate;

  FeedCountData({this.newsfeedsAggregate});

  FeedCountData.fromJson(Map<String, dynamic> json) {
    newsfeedsAggregate = json['newsfeeds_aggregate'] != null
        ? new NewsfeedsAggregate.fromJson(json['newsfeeds_aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newsfeedsAggregate != null) {
      data['newsfeeds_aggregate'] = this.newsfeedsAggregate!.toJson();
    }
    return data;
  }
}

class NewsfeedsAggregate {
  Aggregate? aggregate;
  String? sTypename;

  NewsfeedsAggregate({this.aggregate, this.sTypename});

  NewsfeedsAggregate.fromJson(Map<String, dynamic> json) {
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
