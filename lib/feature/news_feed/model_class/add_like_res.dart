class AddLikeRes {
  AddLikeData? data;

  AddLikeRes({this.data});

  AddLikeRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AddLikeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AddLikeData {
  InsertNewsfeedsLikesOne? insertNewsfeedsLikesOne;

  AddLikeData({this.insertNewsfeedsLikesOne});

  AddLikeData.fromJson(Map<String, dynamic> json) {
    insertNewsfeedsLikesOne = json['insert_newsfeeds_likes_one'] != null
        ? new InsertNewsfeedsLikesOne.fromJson(
            json['insert_newsfeeds_likes_one'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.insertNewsfeedsLikesOne != null) {
      data['insert_newsfeeds_likes_one'] =
          this.insertNewsfeedsLikesOne!.toJson();
    }
    return data;
  }
}

class InsertNewsfeedsLikesOne {
  String? id;
  String? sTypename;

  InsertNewsfeedsLikesOne({this.id, this.sTypename});

  InsertNewsfeedsLikesOne.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['__typename'] = this.sTypename;
    return data;
  }
}
