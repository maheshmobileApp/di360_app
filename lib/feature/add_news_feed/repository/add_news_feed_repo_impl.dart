import 'package:di360_flutter/core/api_constants.dart';
import 'package:di360_flutter/core/base_api_cilent.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/add_news_feed/querys/update_news_feed.dart';
import 'package:di360_flutter/feature/add_news_feed/repository/add_news_feed_repository.dart';

class AddNewsFeedRepoImpl implements AddNewsFeedRepository {
  final HttpService http = HttpService();
  final baseClient = BaseApiClient();
  @override
  Future<dynamic> addNewsFeed(variables) async {
    final endpoint = ApiConst.newsfeedCreation;
    final res = await baseClient.postCall(endpoint, payload : variables, isTokenRequired: true);
    return res;
  }
  
  @override
  Future<dynamic> updateNewsFeed(variables) async {
    final res = await http.mutation(updatedTheNewsFeedQuery, variables);
    return res;
  }
}
