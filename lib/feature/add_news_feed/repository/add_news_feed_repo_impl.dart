import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/add_news_feed/querys/add_news_feed_query.dart';
import 'package:di360_flutter/feature/add_news_feed/querys/update_news_feed.dart';
import 'package:di360_flutter/feature/add_news_feed/repository/add_news_feed_repository.dart';

class AddNewsFeedRepoImpl implements AddNewsFeedRepository {
  final HttpService http = HttpService();
  @override
  Future<dynamic> addNewsFeed(variables) async {
    final res = await http.mutation(addNewsFeedQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> updateNewsFeed(variables) async {
    final res = await http.mutation(updatedTheNewsFeedQuery, variables);
    return res;
  }
}
