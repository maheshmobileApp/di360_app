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
  Published? published;
  Published? pending;
  Published? unpublished;

  FeedCountData({this.published, this.pending, this.unpublished});

  FeedCountData.fromJson(Map<String, dynamic> json) {
    published = json['published'] != null
        ? new Published.fromJson(json['published'])
        : null;
    pending = json['pending'] != null
        ? new Published.fromJson(json['pending'])
        : null;
    unpublished = json['unpublished'] != null
        ? new Published.fromJson(json['unpublished'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.published != null) {
      data['published'] = this.published!.toJson();
    }
    if (this.pending != null) {
      data['pending'] = this.pending!.toJson();
    }
    if (this.unpublished != null) {
      data['unpublished'] = this.unpublished!.toJson();
    }
    return data;
  }
}

class Published {
  Aggregate? aggregate;

  Published({this.aggregate});

  Published.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}
