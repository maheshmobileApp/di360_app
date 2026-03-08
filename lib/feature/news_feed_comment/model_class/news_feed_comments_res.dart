import 'package:di360_flutter/feature/home/model_class/news_feed_comment_res.dart';

class NewsFeedCommentsRes {
  NewsFeedCommentData? data;

  NewsFeedCommentsRes({this.data});

  NewsFeedCommentsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new NewsFeedCommentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NewsFeedCommentData {
  List<NewsFeedsComments>? newsFeedsComments;

  NewsFeedCommentData({this.newsFeedsComments});

  NewsFeedCommentData.fromJson(Map<String, dynamic> json) {
    if (json['news_feeds_comments'] != null) {
      newsFeedsComments = <NewsFeedsComments>[];
      json['news_feeds_comments'].forEach((v) {
        newsFeedsComments!.add(new NewsFeedsComments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newsFeedsComments != null) {
      data['news_feeds_comments'] =
          this.newsFeedsComments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
