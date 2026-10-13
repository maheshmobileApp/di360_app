import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/news_feed_comment/model_class/news_feed_comments_res.dart';
import 'package:di360_flutter/feature/news_feed_comment/query/get_comments_query.dart';
import 'package:di360_flutter/feature/news_feed_comment/query/get_replies_query.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/repository/news_feed_community_comment_repo.dart';

class NewsFeedCommunityCommentRepoImpl implements NewsFeedCommunityCommentRepo{
  final HttpService http = HttpService();

  @override
  Future<NewsFeedCommentData> getComments(variables) async {
    final res = await http.query(getCommentsQuery, variables: variables);
    return NewsFeedCommentData.fromJson(res);
  }

  
  @override
  Future<NewsFeedCommentData> getReplies(variables) async {
    final res = await http.query(getRepliesQuery, variables: variables);
    return NewsFeedCommentData.fromJson(res);
  }
}