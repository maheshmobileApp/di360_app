import 'package:di360_flutter/core/api_constants.dart';
import 'package:di360_flutter/core/base_api_cilent.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/model_class/credit_cost_res.dart';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/model_class/credits_balance_res.dart';
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

  @override
  Future<creditsBalanceRes?> getCreditsBalance(String creditId) async {
    final endpoint = "${ApiConst.creditBalance}$creditId";
    final res = await baseClient.getCall(endpoint);
    if (res is Map) {
      return creditsBalanceRes.fromJson(Map<String, dynamic>.from(res));
    }
    return null;
  }


   @override
  Future<List<creditsCostsRes>?> getCreditsCost() async {
    final endpoint = ApiConst.creditCost;
    final res = await baseClient.getCall(endpoint);

    if (res is List) {
      return res.map((item) => creditsCostsRes.fromJson(Map<String, dynamic>.from(item))).toList();
    }
    return null;

  }
}
