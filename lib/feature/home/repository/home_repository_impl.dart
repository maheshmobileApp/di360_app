import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/home/querys/get_all_news_feed_query.dart';
import 'package:di360_flutter/feature/home/querys/get_followers_query.dart';
import 'package:di360_flutter/feature/home/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HttpService _http = HttpService();

  @override
  Future<dynamic> getAllNewsFeed(int offset, int limit) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final myCommunityIds =
        await LocalStorage.getStringList(LocalStorageConst.myCommunityIds);

    final variables = {
      "where": {
        "status": {"_eq": "PUBLISHED"},
        "_and": [
          {
            "_or": [
              {
                "community_type": {"_eq": "BOTH"}
              },
              {
                "user_id": {"_eq": userId}
              },
              if (communityId.isNotEmpty || myCommunityIds.isNotEmpty)
                {
                  "community_id": {
                    "_in":
                        communityId.isNotEmpty ? [communityId] : myCommunityIds
                  }
                }
            ]
          },
          {
            "_not": {
              "newsfeed_user_actions": {
                "created_by_id": {"_eq": userId},
                "entity_type": {"_eq": "POST"},
                "action": {
                  "_in": ["HIDE", "REPORT"]
                },
                "status": {"_eq": "ACTIVE"}
              }
            }
          },
          {
            "_not": {
              "blocked_by_user_actions": {
                "created_by_id": {"_eq": userId},
                "entity_type": {"_eq": "PROFILE"},
                "action": {"_eq": "BLOCK"},
                "status": {"_eq": "ACTIVE"}
              }
            }
          }
        ]
      },
      "limit": limit,
      "offset": offset,
      "userId": userId,
      //"roleType": roleType
    };
    final res = await _http.query(getAllNewsfeedsQuery, variables: variables);
    return res;
  }

  @override
  Future getFollowerCount() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    var res =
        await _http.query(getFollowersQuery, variables: {'userId': userId});
    return res;
  }
}
