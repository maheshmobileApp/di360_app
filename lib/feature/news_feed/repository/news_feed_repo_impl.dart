import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/news_feed/querys/get_news_feeds_query.dart';
import 'package:di360_flutter/feature/news_feed/querys/hide_post_query.dart';
import 'package:di360_flutter/feature/news_feed/repository/news_feed_repository.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';

class NewsFeedRepoImpl implements NewsFeedRepository {
  final HttpService http = HttpService();
  @override
  Future<dynamic> hidePost(variables) {
    final res = http.mutation(HidePostQuery, variables);
    return res;
  }

  @override
  Future<dynamic> blockUser(variables) {
    final res = http.mutation(BlockUserQuery, variables);
    return res;
  }

  @override
  Future<dynamic> getAllNewsFeed(int offset, int limit, String searchText,
      {String? feedType, String? categoryType}) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final userType = await LocalStorage.getStringVal(LocalStorageConst.type); 
    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final myCommunityIds =
        await LocalStorage.getStringList(LocalStorageConst.myCommunityIds);
    final professionId = await LocalStorage.getStringVal(LocalStorageConst.professionId);
    final variables = {
      "where": {
        "_and": [
          {
            "status": {"_eq": "PUBLISHED"}
          },
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
          if (feedType != null)
            {
              "feed_type": {"_eq": feedType}
            },
          if (categoryType != null)
            {
              "category_type": {"_eq": categoryType}
            },
          {
            "_or": [
              {
                "description": {"_ilike": "%$searchText%"}
              },
              {
                "title": {"_ilike": "%$searchText%"}
              },
              {
                "admin_user": {
                  "name": {"_ilike": "%$searchText%"}
                }
              },
              {
                "dental_practice": {
                  "business_name": {"_ilike": "%$searchText%"}
                }
              },
              {
                "dental_supplier": {
                  "business_name": {"_ilike": "%$searchText%"}
                }
              },
              {
                "dental_professional": {
                  "name": {"_ilike": "%$searchText%"}
                }
              }
            ]
          },
          if (userType != UserRole.admin.name && professionId.isNotEmpty)
          {
                "_or": [
                    {
                        "access_rules": {
                            "directory_category_id": {
                                "_eq": professionId
                            }
                        }
                    },
                    {
                        "category_type": {
                            "_is_null": true
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
    final res = await http.query(getAllNewsfeedsQuery, variables: variables);
    return res;
  }
}
