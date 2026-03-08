import 'package:di360_flutter/feature/news_feed_comment/model_class/news_feed_comments_res.dart';

abstract class NewsFeedCommentRepository {
  Future<NewsFeedCommentData> getComments(dynamic variables);
  Future<NewsFeedCommentData> getReplies(dynamic variables);
}
