import 'package:di360_flutter/feature/news_feed_community/model/get_news_feed_community_res.dart';

abstract class NewsFeedCommunityRepository {
  Future<NewsFeedCommunityData> getAllNewsFeeds(dynamic variables);
}