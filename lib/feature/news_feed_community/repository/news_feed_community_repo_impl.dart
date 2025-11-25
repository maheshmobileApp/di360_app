import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/news_feed_community/model/get_news_feed_community_res.dart';
import 'package:di360_flutter/feature/news_feed_community/query/get_all_news_feeds_query.dart';
import 'package:di360_flutter/feature/news_feed_community/repository/news_feed_community_repository.dart';

class NewsFeedCommunityRepoImpl extends NewsFeedCommunityRepository {
  final HttpService http = HttpService();

  @override
  Future<NewsFeedCommunityData> getAllNewsFeeds(dynamic variables) async {
    print("-------------------getAllNewsFeeds Calling----------------");
    final res = await http.query(getAllNewsFeedQuery, variables: variables);
    final data = NewsFeedCommunityData.fromJson(res);

    return data;
  }
}
