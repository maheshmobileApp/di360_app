import 'package:di360_flutter/feature/news_feed_community/model/banner_url_res.dart';
import 'package:di360_flutter/feature/news_feed_community/model/get_feed_count_res.dart';
import 'package:di360_flutter/feature/news_feed_community/model/get_news_feed_community_res.dart';

abstract class NewsFeedCommunityRepository {
  Future<NewsFeedCommunityData> getAllNewsFeeds(dynamic variables);
  Future<dynamic> communityLike(dynamic variables);
  Future<dynamic> communityUnLike(dynamic variables);
  Future<FeedCountData> feedCount(dynamic variables);
  Future<dynamic> updateNewsFeedStatus(dynamic variables);
  Future<dynamic> addNewsFeed(dynamic variables);
  Future<dynamic> updateNewsFeedCommunity(dynamic variables);
  Future<dynamic> deleteNewsFeedCommunity(dynamic variables);
  Future<BannerUrlData> getBannerUrl(dynamic variables);
  Future<dynamic> leaveCommunity(dynamic variables);
}
