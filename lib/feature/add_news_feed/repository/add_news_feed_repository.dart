import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/model_class/credit_cost_res.dart';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/model_class/credits_balance_res.dart';

abstract class AddNewsFeedRepository {
  Future<dynamic> addNewsFeed(dynamic variables);
  Future<dynamic> updateNewsFeed(dynamic variables);
  Future<creditsBalanceRes?> getCreditsBalance(String creditId);
  Future<List<creditsCostsRes>?> getCreditsCost();
}
