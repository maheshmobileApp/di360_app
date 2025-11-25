import 'package:di360_flutter/feature/news_feed_community/model/get_news_feed_community_res.dart';
import 'package:di360_flutter/feature/news_feed_community/repository/news_feed_community_repo_impl.dart';
import 'package:flutter/material.dart';

class NewsFeedCommunityViewModel extends ChangeNotifier {
  final NewsFeedCommunityRepoImpl repo = NewsFeedCommunityRepoImpl();

  NewsFeedCommunityData? newsFeedCommunityData;

  //GET JOIN REQUEST
  Future<void> getAllNewsFeeds() async {
    final variables = {
      "where": {
        "status": {"_eq": "PUBLISHED"},
        "community_id": {"_eq": "f1c8a4e1-7b7e-4a31-9c0e-25b69b75c83d"}
      },
      "limit": 3,
      "offset": 0,
      "userId": "5e3c1d29-f7bf-4463-b868-83fbdcdd148b",
      "roleType": "SUPPLIER"
    };
    final res = await repo.getAllNewsFeeds(variables);
    if (res != null) {
      print("*************************************data fetched successfully");
      newsFeedCommunityData = res;
    }
    notifyListeners();
  }
}
