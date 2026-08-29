import 'package:di360_flutter/feature/add_news_feed/model_class/credits_balance_res.dart';

abstract class AddNewsFeedRepository {
  Future<dynamic> addNewsFeed(dynamic variables);
  Future<dynamic> updateNewsFeed(dynamic variables);
  Future<creditsBalanceRes?> getCreditsBalance(String creditId);
}
