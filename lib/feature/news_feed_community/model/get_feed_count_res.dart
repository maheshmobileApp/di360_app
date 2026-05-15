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
  PendingNews? pendingNews;
  PendingNews? publishedNews;
  PendingNews? unpublishedNews;

  FeedCountData({this.pendingNews, this.publishedNews, this.unpublishedNews});

  FeedCountData.fromJson(Map<String, dynamic> json) {
    pendingNews = json['pendingNews'] != null
        ? new PendingNews.fromJson(json['pendingNews'])
        : null;
    publishedNews = json['publishedNews'] != null
        ? new PendingNews.fromJson(json['publishedNews'])
        : null;
    unpublishedNews = json['unpublishedNews'] != null
        ? new PendingNews.fromJson(json['unpublishedNews'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pendingNews != null) {
      data['pendingNews'] = this.pendingNews!.toJson();
    }
    if (this.publishedNews != null) {
      data['publishedNews'] = this.publishedNews!.toJson();
    }
    if (this.unpublishedNews != null) {
      data['unpublishedNews'] = this.unpublishedNews!.toJson();
    }
    return data;
  }
}

class PendingNews {
  Aggregate? aggregate;
  String? sTypename;

  PendingNews({this.aggregate, this.sTypename});

  PendingNews.fromJson(Map<String, dynamic> json) {
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
