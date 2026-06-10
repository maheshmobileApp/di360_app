import 'package:di360_flutter/feature/news_feed_community/model/get_feed_count_res.dart';

abstract class NewsFeedRepository {
  Future<dynamic> getAllNewsFeed(int offset, int limit, String searchText,
      {String? feedType, String? categoryType, String? status});
  Future<dynamic> hidePost(dynamic variables);
  Future<dynamic> blockUser(dynamic variables);
  Future<FeedCountData> feedCount(dynamic variables);
  Future<dynamic> publishAndUnpublishNewsFeed(String newsFeedId, String status);
}
