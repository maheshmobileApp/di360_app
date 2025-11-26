import 'package:di360_flutter/feature/news_feed_community/model/get_feed_count_res.dart';
import 'package:di360_flutter/feature/news_feed_community/model/get_news_feed_community_res.dart';

abstract class NewsFeedCommunityRepository {
  Future<NewsFeedCommunityData> getAllNewsFeeds(dynamic variables);
  Future<dynamic> communityLike(dynamic variables);
  Future<dynamic> communityUnLike(dynamic variables);
  Future<FeedCountData> feedCount(dynamic variables);
   Future<dynamic> updateNewsFeedStatus(dynamic variables);
   Future<dynamic> addNewsFeed(dynamic variables);
}